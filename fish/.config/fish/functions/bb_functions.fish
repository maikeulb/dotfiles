# {{{ Mage stuff

function mage-sync
  rsync -a /Users/michael.barnes/Birchbox/birchbox/ michaelbarnes.dev.birchbox.com:~/unit/com.birchbox.web/repo
end  

function mage-flush
  ssh dev 'echo flush_all | nc memc-mage 11211'
end  

function remote-breakage
  ssh dev 'php /home/michaelbarnes/unit/com.birchbox.web/repo/local/scripts/addon_orders/breakage_fix_test.php'
end  

# }}}

# {{{ Local Remote Port Forwarding

function proxy-on
  ssh -fN bbms
end  

function proxy-check
  ssh -O check bbms
end  

function proxy-off
  ssh -O exit bbms
end  

function mage-forward
  ssh -NL $LOCAL_MAGE_PORT:$REMOTE_MAGE_HOST:$REMOTE_MAGE_PORT $REMOTE_MACHINE_USER@$REMOTE_MACHINE_HOST
end  

function box-forward
  ssh -NL $LOCAL_BOX_PORT:$REMOTE_BOX_HOST:$REMOTE_BOX_PORT $REMOTE_MACHINE_USER@$REMOTE_MACHINE_HOST
end  

function tools-forward
  ssh -NL $LOCAL_TOOLS_PORT:$REMOTE_TOOLS_HOST:$REMOTE_TOOLS_PORT $REMOTE_USER@$REMOTE_HOST
end  

function subs-forward
  ssh -NL $LOCAL_SUBS_PORT:$REMOTE_SUBS_HOST:$REMOTE_SUBS_PORT $REMOTE_USER@$REMOTE_HOST
end  

function all-forward
  ssh $REMOTE_MACHINE_USER@$REMOTE_MACHINE_HOST -NL $LOCAL_TOOLS_PORT:$REMOTE_TOOLS_HOST:$REMOTE_TOOLS_PORT -NL $LOCAL_BOX_PORT:$REMOTE_BOX_HOST:$REMOTE_BOX_PORT -NL $LOCAL_MAGE_PORT:$REMOTE_MAGE_HOST:$REMOTE_MAGE_PORT -NL $LOCAL_SUBS_PORT:dbrw-subscription:$REMOTE_SUBS_PORT 
end  

function bbms-stage-rmq-forward
  ssh -NL 15672:127.0.0.1:15672 app7.nyc2.birchbox.com
end  

function bbms-prod-rmq-forward
  ssh -NL 55672:127.0.0.1:55672 -L 15672:127.0.0.1:15672 queue0.nyc2.birchbox.com
end  

# }}}

# {{{ Local Remote Port Forwarding

function mycli-comm-prod
  mycli mysql://$SYS0_USER:$SYS0_PASSWORD@$SYS0_HOST:$SYS_PORT
end  

function mycli-mage
  mycli mysql://$REMOTE_MAGE_USER:$REMOTE_MAGE_PASS@localhost:$LOCAL_MAGE_PORT
end  

function mycli-mage-remote
  mycli mysql://$REMOTE_MAGE_USER:$REMOTE_MAGE_PASS@$REMOTE_MAGE_HOST:$REMOTE_MAGE_PORT
end  

# }}}

# {{{ Curling stuff to BBMS

function stage_curl_sendgrid
  ssh sys0 "curl -X POST -H \"Content-Type:application/json\" -H \"Accept:application/json\" -d '{\"template\": \"6cb0b86d-d822-431b-889a-99d589683c78\", \"email\": \"michael.barnes@birchbox.com\", \"region\": \"US\", \"message\": \"M_Breakage_1\", \"vars\": {\"first_name\":\"michael\", \"tracking_number\": \"123\"}, \"customerId\": 123, \"provider\": \"sendgrid\" }' \"http://bbms-stg.pvt.nyc2.birchbox.com/send/triggered\""
end

function prod_curl_sendgrid
  ssh sys0 "curl -X POST -H \"Content-Type:application/json\" -H \"Accept:application/json\" -d '{\"template\": \"6cb0b86d-d822-431b-889a-99d589683c78\", \"email\": \"michael.barnes@birchbox.com\", \"region\": \"US\", \"message\": \"M_Breakage_1\", \"vars\": {\"first_name\":\"michael\", \"tracking_number\": \"123\"}, \"customerId\": 123, \"provider\": \"sendgrid\" }' \"http://bbms.nyc2.birchbox.com:8080/send/triggered\"" 
end

function stage_curl
  ssh sys0 "curl -X POST -H \"Content-Type:application/json\" -H \"Accept:application/json\" -d '{\"template\": \"6fb09bcd-e15d-48a3-a0bb-02e7b0b2fc52\", \"email\": \"michael.barnes@birchbox.com\", \"region\": \"US\", \"message\": \"M_Breakage_1\", \"vars\": {}, \"customerId\": 123 }' \"http://bbms-stg.pvt.nyc2.birchbox.com/send/triggered\""
end

function prod_curl
  ssh sys0 "curl -X POST -H \"Content-Type:application/json\" -H \"Accept:application/json\" -d '{\"template\": \"6cb0b86d-d822-431b-889a-99d589683c78\", \"email\": \"michael.barnes@birchbox.com\", \"region\": \"US\", \"message\": \"M_Breakage_1\", \"vars\": {\"first_name\":\"michael\", \"tracking_number\": \"123\"}, \"customerId\": 123 }' \"http://bbms.nyc2.birchbox.com:8080/send/triggered\"" 
end

function stage_curl_box_has_shipped_parvez
  ssh sys0 "curl -X POST -H \"Content-Type:application/json\" -H \"Accept:application/json\" -d '{\"customerId\": 40, \"email\": \"parvez.rafi@birchbox.com\", \"countryCode\": \"gb\", \"trackingUrl\": \"2343\", \"trackingNumber\": 123, \"shippingCycleId\": 3, \"shopId\" : 1, \"subscriptionVertical\": \"mens\"}' \"http://bbms-stg.pvt.nyc2.birchbox.com/trigger/box_has_shipped\""
end

function stage_curl_box_has_shipped_gb
  ssh sys0 "curl -X POST -H \"Content-Type:application/json\" -H \"Accept:application/json\" -d '{\"customerId\": 5, \"email\": \"michael.barnes@birchbox.com\", \"countryCode\": \"gb\", \"trackingUrl\": \"2343\", \"trackingNumber\": 333, \"shippingCycleId\": 3, \"shopId\" : 1, \"subscriptionVertical\": \"mens\"}' \"http://bbms-stg.pvt.nyc2.birchbox.com/trigger/box_has_shipped\""
end

function stage_curl_box_has_shipped_personal
  ssh sys0 "curl -X POST -H \"Content-Type:application/json\" -H \"Accept:application/json\" -d '{\"customerId\": 5, \"email\": \"michaelbarne.s@birchbox.com\", \"countryCode\": \"gb\", \"trackingUrl\": \"2343\", \"trackingNumber\": 333, \"shippingCycleId\": 3, \"shopId\" : 1, \"subscriptionVertical\": \"mens\"}' \"http://bbms-stg.pvt.nyc2.birchbox.com/trigger/box_has_shipped\""
end

function stage_curl_reviews_completed
  ssh sys0 "curl -X POST -H \"Content-Type:application/json\" -H \"Accept:application/json\" -d '{\"email\": \"michael.barnes@birchbox.com\", \"userId\": 4, \"boxName\": \"fun\", \"countryCode\": \"gb\"}' \"http://bbms-stg.pvt.nyc2.birchbox.com/trigger/reviews_completed\""
end

# }}}

# {{{ Misc stuff

function bb_login
   http --form post https://api.staging.birchbox.com/user/login email=michael.barnes@birchbox.com password=tester | jq -r .id
end

function test_sub
   http post http://api.staging.birchbox.com/subscriptions/pause\?vertical_id=1\?shipping_cycle=1 x-session-id:$argv x-magento-session-id:$argv
end

function test_unsub
   http delete http://api.staging.birchbox.com/subscriptions/pause/5703 x-session-id:$argv x-magento-session-id:$argv
end

# }}}
