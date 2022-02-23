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

function schedule-cron
    http post http://localhost:4200/schedule_email_cron cron_name=sample_choices
end

function schedule-cron-breakage
    http post http://localhost:4200/schedule_email_cron cron_name=breakage_m_0
end

# }}}

# {{{ Project aliases

alias ea='nvim $APPLICATION_YML/application.yml'

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

function bbms-stg-forward
    ssh -NL 4201:bbms-stg.pvt.nyc2.birchbox.com:80 michaelbarnes@sys0.nyc2.birchbox.com
end

function bbms-prod-forward
    ssh -NL 4200:bbms.nyc2.birchbox.com:8080 michaelbarnes@sys0.nyc2.birchbox.com
end

function shapi-forward
    ssh -NL 3000:api.int.nyc2.birchbox.com:80 michaelbarnes@sys0.nyc2.birchbox.com
end

function shapi-forward-stage
    ssh -NL 3001:api-stg.int.nyc2.birchbox.com:80 michaelbarnes@sys0.nyc2.birchbox.com
end

function bbop-forward
    ssh michaelbarnes@sys0.nyc2.birchbox.com -NL 3306:dbrw-c2-stg.int.nyc2.birchbox.com:3306 
end

# function bbop-forward
#     ssh michaelbarnes@sys0.nyc2.birchbox.com -NL 3306:dbrw-bbop-shipments-stg.int:3306 
# end

    # host2: dbrw-bbop-shipments-stg.int                                                                                                                         
# function forward
#     # ssh michaelbarnes@michaelbarnes.dev.birchbox.com -NL 3306:dbrw-mage:3306
#     ssh michaelbarnes@michaelbarnes.dev.birchbox.com -NL 3306:dbrw-mage:3306 3311:dbro-product:3306 11211:memc-session:11211 8888:solr:8080
# end

function all-forward
    ssh $REMOTE_MACHINE_USER@$REMOTE_MACHINE_HOST -NL $LOCAL_TOOLS_PORT:$REMOTE_TOOLS_HOST:$REMOTE_TOOLS_PORT -NL $LOCAL_BOX_PORT:$REMOTE_BOX_HOST:$REMOTE_BOX_PORT -NL $LOCAL_MAGE_PORT:$REMOTE_MAGE_HOST:$REMOTE_MAGE_PORT -NL $LOCAL_WHSE_PORT:$REMOTE_WHSE_HOST:$REMOTE_WHSE_PORT
    # ssh $REMOTE_MACHINE_USER@$REMOTE_MACHINE_HOST -NL $LOCAL_TOOLS_PORT:$REMOTE_TOOLS_HOST:$REMOTE_TOOLS_PORT -NL $LOCAL_BOX_PORT:$REMOTE_BOX_HOST:$REMOTE_BOX_PORT -NL $LOCAL_MAGE_PORT:$REMOTE_MAGE_HOST:$REMOTE_MAGE_PORT
end


function mage-forward
    ssh -NL $LOCAL_MAGE_PORT:$REMOTE_MAGE_HOST:$REMOTE_MAGE_PORT $REMOTE_MACHINE_USER@$REMOTE_MACHINE_HOST
end

# function redshift-forward 
#     ssh -NL 5440:127.0.0.1:5439 bb-redshift-prod.ctru1bqr81bl.us-east-1.redshift.amazonaws.com */
# end 

# function redshift-forward
#     ssh -NL 5440:127.0.0.1:5439 production-0-cluster.csme2xvziial.us-east-1.redshift.amazonaws.com
# end

function redshift-forward
    ssh -L 5440:127.0.0.1:5439 michaelbarnes@54.163.167.214
end

# function redshift-forward
#     ssh -NL 5440:127.0.0.1:5439 michaelbarnes@54.163.167.214
# end

function box-forward
    ssh -NL $LOCAL_BOX_PORT:$REMOTE_BOX_HOST:$REMOTE_BOX_PORT $REMOTE_MACHINE_USER@$REMOTE_MACHINE_HOST
end

function tools-forward
    ssh -NL $LOCAL_TOOLS_PORT:$REMOTE_TOOLS_HOST:$REMOTE_TOOLS_PORT $REMOTE_MACHINE_USER@$REMOTE_MACHINE_HOST
end

function subs-forward
    ssh -NL $LOCAL_SUBS_PORT:$REMOTE_SUBS_HOST:$REMOTE_SUBS_PORT $REMOTE_MACHINE_USER@web9.nyc2.birchbox.com
end

function product-dev-rmq-forward
    ssh -NL 15672:127.0.0.1:15672 queue.pvt.birchbox.com
end

function solr_forward
    # ssh -A web6.nyc2.birchbox.com -L8080:solr.pvt.nyc2.birchbox.com:8080
    ssh -NL 8080:solr.pvt.nyc2.birchbox.com:8080 web6.nyc2.birchbox.com
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

function stage_curl_schedule
    ssh sys0 "curl -X POST -H \"Content-Type:application/json\" -H \"Accept:application/json\" -d '{\"cron_name\": \"breakage_w_2\" }' \"http://bbms-stg.pvt.nyc2.birchbox.com/schedule_email_cron\""
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

function stage_curl_cron
    ssh sys0 "curl -X POST -H \"Content-Type:application/json\" -H \"Accept:application/json\" -d '{\"cron_name\": \"breakage_m_0\"}' \"http://bbms-stg.pvt.nyc2.birchbox.com/schedule_email_cron\""
end

function prod_curl_cron
    ssh sys0 "curl -X POST -H \"Content-Type:application/json\" -H \"Accept:application/json\" -d '{\"cron_name\": \"breakage_m_0\"}' \"http://bbms.nyc2.birchbox.com:8080/schedule_email_cron\""
end

function prod_health
    ssh sys0 "curl -X GET 'http://bbms.nyc2.birchbox.com:8080/monitor/health'"
end

function stage_health
    ssh sys0 "curl -X GET 'http://bbms-stg.nyc2.birchbox.com:8080/monitor/health'"
end

function prod_bbop_health
    ssh sys0 "curl -X GET 'bbop-shipments.nyc2.birchbox.com:8080/actuator/health'"
end

function prod_bbop_orders_health
    ssh sys0 "curl -X GET 'bbop-orders.nyc2.birchbox.com:8080/health'"
end

function prod_bbop_orders_actuator_health
    ssh sys0 "curl -X GET 'bbop-orders.nyc2.birchbox.com:8080/actuator/health'"
end

function stage_curl_shapi_breaking
    ssh sys0 "curl -X GET 'http://api-stg.int.nyc2.birchbox.com/shapi/breaking_subs?vertical=2'"
end

function prod_curl_shapi_breaking
    ssh sys0 "curl -X GET 'http://api.int.nyc2.birchbox.com/shapi/breaking_subs?vertical=2'"
end

# }}}

# {{{ Misc stuff

function staging_curl_content
    ssh sys0 "curl -X GET 'http://api.staging.birchbox.com/content/v2/search?query=kal'"
end

function prod_curl_shapi
    ssh sys0 "curl -X GET 'http://api.int.nyc2.birchbox.com/shapi/'"
end

function prod_curl_content
    ssh sys0 "curl -X GET 'http://api.birchbox.com/content/v2/search?query=kalingggg'"
end

function prod_curl_content_faq
    ssh sys0 "curl -X GET 'http://api.birchbox.com/content/faq'"
end

function dev_curl_content
    ssh dev "curl -X GET 'http://api.michaelbarnes.dev.birchbox.com/content/v2/search?query=kal'"
end

function bb_login
    # http --form post https://api.staging.birchbox.com/user/login email=michael.barnes@birchbox.com password=tester | jq -r .id
    # http --form post https://api.staging.birchbox.com/user/login email=michael.barnes@birchbox.com password=tester
    http --form post https://api.staging.birchbox.com/user/login email=3@3.net password=tester
end

function dev_login
    http --form post https://api.staging.birchbox.com/user/login email=michael.barnes@birchbox.com password=tester | jq -r .id
end

function test_sub
    http post http://api.staging.birchbox.com/subscriptions/pause\?vertical_id=1\?shipping_cycle=1 x-session-id:$argv x-magento-session-id:$argv
end

function test_unsub
    http delete http://api.staging.birchbox.com/subscriptions/pause/5703 x-session-id:$argv x-magento-session-id:$argv
end

# }}}
