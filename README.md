# Salesforce to Marketing Cloud Subscription Sync
## Introduction
By default, subscribing and unsubscribing a Lead/Contact in Salesforce and syncing to Marketing Cloud requires the clicking of a Unsubscribe or Resubscribe custom link.

This process is a bit cumbersome, and also requires the Salesforce user to be synced to a Marketing Cloud user.

This package provides code for automating changes of the Email Opt Out (HasOptedOutOfEmail) on Lead and Contact objects by subscribing/unsubscribing the subscriber in Marketing Cloud via API. It will attempt a real-time integration initially, but will also retry in 15 minute batches as a API user if the user who initiates the change isn't synced to a Marketing Cloud user.

## Installation
Note: This package requires that the Marketing Cloud Connect package (v5+) is installed. More details here: 
https://help.marketingcloud.com/en/documentation/integrated_products__crm_and_web_analytic_solutions/marketing_cloud_connector_v5/


1. Install package to your Org:
[![Deploy to Salesforce](https://andrewfawcett.files.wordpress.com/2014/09/deploy.png "Deploy to Salesforce")](https://githubsfdeploy.herokuapp.com/app/githubdeploy/benedwards44/sf-mc-subscription-sync)
2. 



