<!-- -*- sgml -*- -->
<link href="/resources/acs-templating/mktree.css" rel="stylesheet" type="text/css" />

<script src="/resources/acs-templating/mktree.js" language="javascript"></script>

<if @shaded_p@ false>


<div id="toolbox">

<div class="contents">
<span style="align:left;">
<a href="#" onClick="expandTree('tree1'); return false;">Expand all</a> | <a href="#" onClick="collapseTree('tree1'); return false;">Collapse
 All</a> 
</span>


        <ul class="mktree" id="tree1">
            <li>#forums-portlet.pretty_name#

                       <ul>
                        <multiple name="forums">
                        
                        <li><a href="/latest/index?itemId=@forums.object_id@&object=1">@forums.title@</a><br><i>@forums.last_modified@</i></li>
                        </multiple>
                       </ul>
            </li>
            <li>#fs-portlet.pretty_name#
              <ul>
                        <multiple name="fs">
                        <li><a href="/latest/index?itemId=@fs.object_id@&object=1">@fs.title@</a> <i>@fs.last_modified@</i></li>
                        </multiple>
                       </ul>
            </li>
<li>#assessment.Assessments#
              <ul>
                        <multiple name="assessment_sessions">
                        <li><a href="/latest/index?itemId=@assessment_sessions.assessment_id@&object=0&newURL=@assessment_sessions.assessment_url@"  >@assessment_sessions.title@</a><br> <i>@assessment_sessions.publish_date@</i></li>
                        </multiple>
                       </ul>

           </li>
          <if @is_lors@>
            <li>#lorsm-portlet.Learning_Materials#
                      <ul>
                        <multiple name="d_courses">
                        <li>@d_courses.course_url;noquote@   <br> <i>@d_courses.creation_date@</i></li>
                        </multiple>

                      </ul>
            </li>
         </if>
        </ul>

     </div>
</div>
<br> <br>


</if>

<else>
 
    &nbsp;
  
</else>

