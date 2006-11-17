ad_library {
    Procedures to support the latest portlet

    @creation-date  25 August 2006
    @author Cesar Claveria (cesar@viaro.net)

}

namespace eval latest_portlet {}



ad_proc -private latest_portlet::after_install {} {
    Create the datasources needed by the latest  portlet.
} {
    ns_log notice "Entering latest_portlet::after_install"
    db_transaction {
        set ds_id [portal::datasource::new  -name "latest_portlet"  -description "Latest Stuff Portlet"]

        portal::datasource::set_def_param \
            -datasource_id $ds_id \
            -config_required_p t \
            -configured_p t \
            -key shadeable_p \
            -value t

        portal::datasource::set_def_param \
            -datasource_id $ds_id \
            -config_required_p t \
            -configured_p t \
            -key hideable_p \
            -value t

        
        portal::datasource::set_def_param \
            -datasource_id $ds_id \
            -config_required_p t \
            -configured_p t \
            -key user_editable_p \
            -value f

        portal::datasource::set_def_param \
            -datasource_id $ds_id \
            -config_required_p t \
            -configured_p t \
            -key shaded_p \
            -value f

        portal::datasource::set_def_param \
            -datasource_id $ds_id \
            -config_required_p t \
            -configured_p t \
            -key link_hideable_p \
            -value f

        portal::datasource::set_def_param \
            -datasource_id $ds_id \
            -config_required_p t \
            -configured_p f \
            -key package_id \
            -value ""

 register_portal_datasource_impl
    }
 latest_portlet::add_to_users
}



ad_proc -private latest_portlet::register_portal_datasource_impl {} {
    Create the service contracts needed by the latest portlet.
} {
   ns_log notice "Entering latest_portlet::register_portal_datasource_impl"
    set spec {
        name "latest_portlet"
        contract_name "portal_datasource"
        owner "latest-portlet"
        aliases {
            GetMyName latest_portlet::get_my_name
            GetPrettyName  latest_portlet::get_pretty_name
            Link latest_portlet::link
            AddSelfToPage latest_portlet::add_self_to_page
            Show latest_portlet::show
            Edit latest_portlet::edit
            RemoveSelfFromPage latest_portlet::remove_self_from_page
        }
    }

    acs_sc::impl::new_from_spec -spec $spec
    ns_log notice "finishing latest_portlet::register_portal_datasource_impl"
}



ad_proc -private latest_portlet::before_uninstall {} {
   Latest Portlet  uninstall proc
} {
    unregister_implementations
    
}


ad_proc -private latest_portlet::unregister_implementations {} {
    Unregister service contract implementations
} {
    acs_sc::impl::delete \
        -contract_name "portal_datasource" \
        -impl_name "latest_portlet"
}
