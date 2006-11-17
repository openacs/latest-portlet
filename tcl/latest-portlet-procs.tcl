ad_library {
    Procedures to support the latest portlet

    @creation-date  25 August 2006
    @author Cesar Claveria (cesar@viaro.net)

}

namespace eval latest_portlet {}


ad_proc -private latest_portlet::get_my_name {
} {
    return "latest_portlet"
}

ad_proc -private latest_portlet::my_package_key {
} {
    return "latest-portlet"
}

ad_proc -public latest_portlet::get_pretty_name {
} {
    return "#latest-portlet.pretty_name#"
}



ad_proc -public latest_portlet::link {
} {
    return ""
}


ad_proc -public latest_portlet::add_self_to_page {
    {-portal_id:required}
    {-package_id:required}
    {-param_action:required}
} {
    Adds a latest PE to the given portal.

    @param portal_id The page to add self to
    @param package_id The community with the folder
   
  @return element_id The new element's id
} {
    return [portal::add_element_parameters \
                -portal_id $portal_id \
                -portlet_name [get_my_name] \
                -value $package_id \
                -force_region [parameter::get_from_package_key -package_key [my_package_key] -parameter "latest_portlet_region"] \
                -pretty_name [get_pretty_name] \
                -param_action $param_action
	    ]
}

ad_proc -public latest_portlet::remove_self_from_page {
    {-portal_id:required}
    {-package_id:required}
} {
    Removes a latest  PE from the given page or the package_id of the
   latest package from the portlet if there are others remaining

    @param portal_id The page to remove self from
    @param package_id
}  {
    ns_log notice "we are going to remove the portlet"
    portal::remove_element_parameters \
        -portal_id $portal_id \
        -portlet_name [get_my_name] \
        -value $package_id
    }

ad_proc -public latest_portlet::show {
    cf
} {
    portal::show_proc_helper \
        -package_key [my_package_key] \
        -config_list $cf \
        -template_src "latest-portlet"
}

####

ad_proc -public latest_portlet::add_to_users {

} {
   db_foreach get_portals_id  "select distinct portal_id from portals where template_id = 1655" {
     ns_log notice "about to add the portlet to user with the portal No. $portal_id"    
     latest_portlet::add_self_to_page -portal_id $portal_id -package_id 0 -param_action overwrite
    
    }
}


ad_proc -public latest_portlet::add_user {
    user_id
} {
    one time user-specifuc init
} {
    set portal_id [dotlrn::get_portal_id -user_id user_id]
    latest_portlet::add_self_to_page -portal_id $portal_id -package_id 0 -param_action overwrite
}