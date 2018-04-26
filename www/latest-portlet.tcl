
ad_page_contract {
    The logic for the latest portlet.

    @creation-user Cesar Claveria (cesar@viaro.net)
   
    @version $Id: latest-portlet.tcl,v 1.0 2006/25/08 08:00:31 
} -query {
}



array set config $cf

set shaded_p $config(shaded_p)

set user_id [ad_maybe_redirect_for_registration]

set latest_url [apm_package_url_from_key  "latest"]

#Get list of pkg ids
set communities_list [db_list communities_all_select  "
   select dotlrn_communities_all.package_id
   from
          dotlrn_communities_all, dotlrn_member_rels_approved
   where
          dotlrn_communities_all.community_id = dotlrn_member_rels_approved.community_id and
          dotlrn_member_rels_approved.user_id = :user_id and archived_p='f'
"]

set packages_names {}
set objects {}
set packages  {}

foreach community $communities_list {
    set snode [site_node::get_node_id_from_object_id -object_id $community]
    foreach package [site_node::get_children -all -node_id $snode -element package_id] {
        if {![empty_string_p $package] } {
            lappend packages $package
        }
    }
}

    if {![llength $packages] == 0 } {
	set pkgs_ids [join $packages ,]
    #Get latest forums information
    latest::forums -pkgs_ids $pkgs_ids
    #Get latest file storage documents
    latest::fs -pkgs_ids $pkgs_ids
    #Get latest assessments
    latest::asm -pkgs_ids $pkgs_ids
    #Get latest lors objects
    # First check is lors is installed, if its not, then do nothing.
set is_lors [db_0or1row check_lors "select package_key, pretty_name, installed_p from apm_package_version_info where package_key = 'lors'
"]

	if {$is_lors == 1} {
	    latest::lors -pkgs_ids $pkgs_ids }

         
    }




