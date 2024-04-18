resource "ibm_lb_service_group" "test_service_group" {
    port            = 8080
    routing_method  = "ROUND_ROBIN"
    routing_type    = "HTTP"
    load_balancer_id = "123456789" 
    allocation      = 200
    timeout         = 60  
    tags            = ["tag1", "tag2"]   
    service_group_id  = "sg-abcdef123456"
    virtual_server_id = "vs-789xyz987654"
}
