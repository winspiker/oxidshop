<div class="groupExp">
   <div [{if $aStep == "save2Brand" || !$dgOttoCategories}] class="exp"[{/if}]>
        <a href="#" onclick="_groupExp(this);return false;" class="rc"><b>[{$type}] &quot;[{$title}]&quot; zu Otto Brand zuordnen ?</b></a>
          <dl>
            <dd>
              <table cellspacing="0" cellpadding="0" border="0">
                <tr>
                  <td class="edittext">
                    <span style="color:#D4021D;font-weight: 800;font-size: 12px;">OTTO</span> 
                  </td>
                  <td class="edittext">
                    <input id="dgOttoManufacturerSearch" name="editval[dgottobrand]" value="[{$oView->getOttoManufacturer()}]" type="text" size="40" placeholder="suchen ..." />
                  </td>
                  <td class="edittext">
                  </td>
                </tr>                
                <tr>
                  <td class="edittext" colspan="3"><br />
                     <button type="submit" class="edittext" name="save" onclick="showPleaseWait();this.form.aStep.value='save2Brand';this.form.fnc.value='save2Brand'">[{oxmultilang ident="GENERAL_SAVE"}]</button><br>
                  </td>
                </tr>
                
              </table>
            </dd>
          </dl>
         <div class="spacer"></div>
   </div>
</div> 
[{oxscript add="( function( $ ) {
    dgOttoManufacturer = {
        options: {},
        _create: function(){

            var self = this;
            var el   = self.element;
            
            el.after( '<div id=\"dgOttoManufacturerResults\" class=\"search-results\" style=\"display: none;\"></div>');
            el.attr( 'autocomplete', 'off' );   
                           
            el.bind( 'keyup change', function(e){   
               self.doSearch( el );
            }); 
            
            $(\".dgClosePop\").click( function() {
                 self.closeSearch();
            });
        },
        doSearch : function( el )
        {
          $.ajax({
            type: \"GET\",
            url: $('#transfer').attr('action'),
            data: { searchparam: el.val(), cl: 'dgottomanufacturer_search' }
          }).done(function( msg ) {
                $('#dgOttoManufacturerResults').html( msg );
                $('#dgOttoManufacturerResults').show();         
          });
        },
        closeSearch : function()
        {
            $('#dgOttoManufacturerResults').hide();       
        },
        showSearch : function()
        {
            $('#dgOttoManufacturerResults').show();       
        }         
    }
    $.widget( \"ui.dgOttoManufacturer\", dgOttoManufacturer );
} )( jQuery );;"}]
[{oxscript add="$( document ).ready(function() { $('#dgOttoManufacturerSearch').dgOttoManufacturer(); });" priority=10}]