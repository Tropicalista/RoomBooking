<!---================= Room Booking System / https://github.com/neokoenig =======================--->
<cfoutput>
<cfparam name="locations">
#panel(title="Data Feeds for your account")# 
	<cfif !structkeyexists(session, "currentuser") OR !len(session.currentuser.apitoken)>
	<div class="alert alert-danger">You do not have an API token associated with your account.</div>
		<p>API useage requires a token to be created for your account. Administrators, or those with user creation privledges can create these for you on request.</p> 
	<cfelse> 
	<p><strong>Careful!</strong> - these URLs provide authenticated read only access to forthcoming events: only use or share them with trusted users. Administrators can revoke access to feeds by regenerating API keys</p>
 	</cfif>
<table class="table">
	<thead>
		<tr>
			<th>Feed Name</th>
			<th>RSS 2.0</th>
			<th>iCal<th>
		</tr>
	</thead>
	<tbody> <tr>
	 	<td>All Locations</td>
		<td>#linkTo(controller="api", onlyPath=false, class="btn btn-primary btn-xs", action="rss2", params="format=xml&token=#session.currentuser.apitoken#", text="RSS")#</td> 
		<td>#linkTo(controller="api", onlyPath=false, class="ical btn btn-info btn-xs", action="ical", params="token=#session.currentuser.apitoken#", text="iCal")#</td>
	 </tr>
	 <cfloop query="locations">
	 <tr>
	 	<td>#name#</td>
		<td>#linkTo(controller="api", onlyPath=false, class="btn btn-primary btn-xs", action="rss2", params="format=xml&location=#id#&token=#session.currentuser.apitoken#", text="RSS")#</td> 
		<td>#linkTo(controller="api", onlyPath=false, class="ical btn btn-info btn-xs", action="ical", params="location=#id#&token=#session.currentuser.apitoken#", text="iCal")#</td>
	 </tr>
	</cfloop>  
	</tbody>
</table>  
#panelEnd()#

<div id="icalmodal" class="modal fade">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
        <h4 class="modal-title">iCal Details:</h4>
      </div>
      <div class="modal-body">
        <p>You can use the iCal link to subscribe to all events or just a single event. In outlook (or similar), add an 'internet calendar' using the link below:</p>
        <textarea id="icaldata" class="form-control" rows=5></textarea>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button> 
      </div>
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
 </div>

<cfsavecontent variable="request.js.ical">
	<script>
$(document).ready(function(){
	$(".ical").on("click", function(e){
		var icallink=$(this).attr("href");
		//alert(icallink);
		e.preventDefault();
		$("##icaldata").val(icallink);
		$('##icalmodal').modal(); 

	}); 

	 //-------------------------------Remove Old Modal Data------------------//
    $('body').on('hidden.bs.modal', '.modal', function () {
        $(this).removeData('bs.modal');
    });

});
</script>
</cfsavecontent>

</cfoutput>