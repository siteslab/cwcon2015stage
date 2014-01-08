<?php

/**
 * @file
 * Page callbacks for the Reviewer Views module.
 */

/*
 * Page callback for personal pending reviews from profile page
 */
function reviewer_views_personal_view($user) {
  $query = new EntityFieldQuery();
  // fieldCondition gets only reviews assigned to current reviewer
  $query->entityCondition('entity_type', 'node')
    ->entityCondition('bundle', 'proposal')
    ->propertyCondition('status', 1)
    ->fieldCondition('field_reviewer', 'uid', $user->uid, '=');
  $result = $query->execute();

  if (isset($result['node'])) {
    $proposal_ids = array_keys($result['node']);
    $proposals = entity_load('node', $proposal_ids);
    foreach ($proposals as $proposal) {
      $title = $proposal->field_proposal_title_2014[LANGUAGE_NONE][0]['value'];
      $reviewer_proposals[$proposal->nid]['title'] = $title;
    }
    $query = new EntityFieldQuery();
    $query->entityCondition('entity_type', 'node')
      ->entityCondition('bundle', 'review')
      ->propertyCondition('uid', $user->uid) //reviews written by this user
      ->addMetaData('account', user_load(1)); // Run the query as user 1.
    $result = $query->execute();
    if (isset($result['node'])) {
      $review_ids = array_keys($result['node']);
      $reviews = entity_load('node', $review_ids);
      foreach ($reviews as $review) {
        if (isset($review->field_node_reference['und'][0]['nid'])) {
          $reviewed_proposal_id = $review->field_node_reference['und'][0]['nid'];
          if (in_array($reviewed_proposal_id, array_keys($reviewer_proposals))) { // make sure this review is about a proposal
            if (isset($review->field_recommendation['und'][0]['value'])) { // HACK
              // Index of array is node reference field of this review
              $reviewer_proposals[$reviewed_proposal_id]['decision'] = $review->field_recommendation['und'][0]['value'];
              $reviewer_proposals[$reviewed_proposal_id]['review_nid'] = $review->nid;
            }
          }
        }
      }
    }

    $header = array('Title', 'Your Review Decision');
    $rows = array();
    foreach ($reviewer_proposals as $nid => $proposal_info) {
      $reviewed = FALSE;
      if (isset($proposal_info['decision'])) {
        $reviewed = TRUE;
        $decision = $proposal_info['decision'];
      }
      else {
        $decision = "<strong>Not yet reviewed</strong>";
      }
      if ($reviewed) {
        $rows[] = array(l($proposal_info['title'], 'node/' . $nid), $decision . " " . l(" View or edit this review", 'node/' . $proposal_info['review_nid']));
      }
      else {
        $rows[] = array(l($proposal_info['title'], 'node/' . $nid), $decision); // l() HACK
      }
    }

    $output = theme('table', array('header' => $header, 'rows' => $rows ));
  }
  else {
    $output = theme('html_tag', array(
      'element' => array(
      '#tag' => 'h3',
      '#value' => 'You have no proposals assigned to you for review right now. Check back later.',
      ),
    ));
  }

  return $output;
}

/**
 * @file
 * Page callbacks for the Reviewer Views module.
 */

/*
 * Page callback for personal pending reviews from profile page
 */
function reviewer_peer_views_personal_view($user) {
  $query = new EntityFieldQuery();
  // fieldCondition gets only reviews assigned to current reviewer
  $query->entityCondition('entity_type', 'node')
    ->entityCondition('bundle', 'proposal')
    ->propertyCondition('status', 1)
    ->fieldCondition('field_peer_reviewer_s_', 'uid', $user->uid, '=');
  $result = $query->execute();

  if (isset($result['node'])) {
    $proposal_ids = array_keys($result['node']);
    $proposals = entity_load('node', $proposal_ids);
    foreach ($proposals as $proposal) {
      $reviewer_proposals[$proposal->nid]['title'] = $proposal->field_proposal_title_2014[LANGUAGE_NONE][0]['value'];
    }
    $query = new EntityFieldQuery();
    $query->entityCondition('entity_type', 'node')
      ->entityCondition('bundle', 'peer_review')
      ->propertyCondition('uid', $user->uid); //reviews written by this user
      //->addMetaData('account', user_load(1)); // Run the query as user 1.
    $result = $query->execute();
    if (isset($result['node'])) {
      $review_ids = array_keys($result['node']);
      $reviews = entity_load('node', $review_ids);
      foreach ($reviews as $review) {
        if (isset($review->field_node_reference['und'][0]['nid'])) {
          $reviewed_proposal_id = $review->field_node_reference['und'][0]['nid'];
          $status = (_peer_review_has_been_reviewed($review)) ? t('Complete') : t('Incomplete');
          $reviewer_proposals[$reviewed_proposal_id]['status'] = l($status, 'node/' . $review->nid);
          $reviewer_proposals[$reviewed_proposal_id]['review_nid'] = $review->nid;

        }
      }
    }

    $header = array('Title', 'Your Review Status');
    $rows = array();
    foreach ($reviewer_proposals as $nid => $proposal_info) {
      $rows[] = array(l($proposal_info['title'], 'node/' . $nid), $proposal_info['status']);
    }

    $output = theme('table', array('header' => $header, 'rows' => $rows ));
  }
  else {
    $output = theme('html_tag', array(
      'element' => array(
        '#tag' => 'h3',
        '#value' => 'You have no proposals assigned to you for review right now. Check back later.',
      ),
    ));
  }

  return $output;
}

/*
 * Page callback for reviewer dashboard for admins
 */
function reviewer_views_dashboard_view() {
  $query = new EntityFieldQuery();
  // Grab all proposals
  $query->entityCondition('entity_type', 'node')
    ->entityCondition('bundle', 'proposal')
    ->propertyCondition('status', 1);
  $result = $query->execute();

  if (isset($result['node'])) {
    $proposal_ids = array_keys($result['node']);
    $proposals = entity_load('node', $proposal_ids);

    $query = new EntityFieldQuery();
    $query->entityCondition('entity_type', 'node')
      ->entityCondition('bundle', 'review');
     // Remove published requirement ->propertyCondition('status', 1);

    $result = $query->execute();
    if (isset($result['node'])) {
      $review_ids = array_keys($result['node']);
      $reviews = entity_load('node', $review_ids);
      foreach ($reviews as $review) {
        if (isset($review->field_node_reference['und'][0]['nid'])) {
          $reviewed_proposal_id = $review->field_node_reference['und'][0]['nid'];
          $reviews2[$reviewed_proposal_id][$review->nid] = array(
            'decision' => $review->field_recommendation['und'][0]['value'],
            'reviewer_uid' => $review->uid,
          );
        }
      }
    }

    $header = array(t('Reviewer'), t('Proposal Title'), t('Recommendation'), t('Final Decision'));
    $rows = array();
    // Below is a (probably) overcomplicated looping to match reviewer UIDs
    // to the UIDs of reviews that were created for proposals
    // We add a row for each proposal reviewer regardless of whether
    // or not she's reviewed yet.
    // The logic loops through and matches reviews with their rightful
    // proposals and provides the decision the reviewer made all the while.
    foreach ($proposals as $proposal_id => $proposal_info) {
      foreach ($proposal_info->field_reviewer[LANGUAGE_NONE] as $key => $reviewer) {
        if (isset($reviews2[$proposal_id])) {
          foreach ($proposal_info->field_reviewer[LANGUAGE_NONE] as $key2 => $value ) {
            $decision = t('No recommendation');
            foreach ($reviews2[$proposal_id] as $review_nid => $review) {
              if ($review['reviewer_uid'] == $reviewer['uid']) {
                $decision = $reviews2[$proposal_id][$review_nid]['decision'] . ' ' . l("View or edit this review", 'node/' . $review_nid);
                unset($reviews2[$proposal_id][$review_nid]);
                break 2;
              }
            }
          }
        }
        else {
          $decision = t("Yet to review");
        }

        $reviewer_uid = $proposal_info->field_reviewer[LANGUAGE_NONE][$key]['uid'];
        $user = user_load($reviewer_uid);
        $reviewer_name = l(theme('display_name', (array)$user), 'user/' . $user->uid);

        $rows[] = array(
          $reviewer_name,
          l($proposal_info->field_proposal_title_2014[LANGUAGE_NONE][0]['value'], 'node/' . $proposal_id),
          $decision,
          empty($proposal_info->field_final_decision) ? "" : $proposal_info->field_final_decision[LANGUAGE_NONE][0]['value'],
        );
      }
    }

    $output = theme('table', array('header' => $header, 'rows' => $rows ));
  }
  else {
    $output = theme('html_tag', array(
      'element' => array(
      '#tag' => 'h3',
      '#value' => t('There are no outstanding proposals.'),
      ),
    ));
  }

  return $output;
}

/*
 * Page callback for peer reviewer dashboard for admins
 */
function reviewer_peer_reviews_dashboard_view() {
  $query = new EntityFieldQuery();
  // Grab all proposals
  $query->entityCondition('entity_type', 'node')
    ->entityCondition('bundle', 'proposal')
    ->propertyCondition('status', 1);
  $result = $query->execute();

  if (isset($result['node'])) {
    $proposal_ids = array_keys($result['node']);
    $proposals = entity_load('node', $proposal_ids);

    $query = new EntityFieldQuery();
    $query->entityCondition('entity_type', 'node')
      ->entityCondition('bundle', 'peer_review')
      ->propertyCondition('status', 1);

    $result = $query->execute();
    if (isset($result['node'])) {
      $review_ids = array_keys($result['node']);
      $reviews = entity_load('node', $review_ids);
      foreach ($reviews as $review) {
        if (isset($review->field_node_reference['und'][0]['nid'])) {
          $reviewed_proposal_id = $review->field_node_reference['und'][0]['nid'];
          $user = user_load($review->uid);

          $reviews2[$reviewed_proposal_id][$review->nid] = array(
            'status' => (_peer_review_has_been_reviewed($review)) ? l('Complete', 'node/' . $review->nid) : t('Incomplete'),
            'reviewer_name' => l(theme('display_name', (array)$user), 'user/' . $user->uid),
          );
        }
      }
    }

    $header = array(t('Peer Reviewer'), t('Proposal Title'), t('Status'));
    $rows = array();
    foreach ($proposals as $proposal_id => $proposal_info) {
      if (isset($reviews2[$proposal_id])) {
        foreach ($reviews2[$proposal_id] as $review_nid => $review_result) {
          $rows[] = array(
            $reviews2[$proposal_id][$review_nid]['reviewer_name'],
            l($proposal_info->field_proposal_title_2014[LANGUAGE_NONE][0]['value'], 'node/' . $proposal_id),
            $reviews2[$proposal_id][$review_nid]['status'],
          );
        }
      }
      else {
        if (!empty($proposal_info->field_peer_reviewer_s_)) {
          $user = user_load($proposal_info->field_peer_reviewer_s_[LANGUAGE_NONE][0]['uid']);
          $name = l(theme('display_name', (array)$user), 'user/' . $user->uid);
        }
        else {
          $name = '';
        }

        $rows[] = array(
          $name,
          l($proposal_info->field_proposal_title_2014[LANGUAGE_NONE][0]['value'], 'node/' . $proposal_id),
          t('Incomplete'),
        );
      }
    }

    $output = theme('table', array('header' => $header, 'rows' => $rows ));
  }
  else {
    $output = theme('html_tag', array(
      'element' => array(
        '#tag' => 'h3',
        '#value' => t('There are no outstanding proposals.'),
      ),
    ));
  }

  return $output;
}