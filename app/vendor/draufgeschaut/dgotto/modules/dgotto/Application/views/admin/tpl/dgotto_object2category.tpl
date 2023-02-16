<div class="groupExp">
   <div [{if $aStep == "save2Category" || !$dgOttoCategories}] class="exp"[{/if}]>
        <a href="#" onclick="_groupExp(this);return false;" class="rc"><b>Otto Kategorie</b></a>
          <dl>
            <dd>
              <table cellspacing="0" cellpadding="0" border="0">
                <tr>
                  <td class="edittext">
                    <span style="color:#D4021D;font-weight: 800;font-size: 12px;">OTTO</span> 
                  </td>
                  <td class="edittext">
                    <input id="dgOttoCategorySearch" name="editval[dgottocategory]" value="[{$oView->getOttoCategory($edit)}]" type="text" size="40" placeholder="suchen ..." />
                    <input id="dgOttoCategorySearchId" name="editval[dgottocategoryid]" value="[{$oView->getOttoCategoryId($edit)}]" type="hidden" />
                    <input id="dgOttoCategorySaveId" name="editval[dgottocategorysaveid]" value="[{$dgottocategorysaveid}]" type="hidden" />
                  </td>
                  <td class="edittext">
                  <br /><br />
                  </td>
                </tr>                
                [{if $dgOttoCategories}]
                <tr>
                  <td class="edittext">
                    gew&auml;hlte Kategorie:
                  </td>
                  <td class="edittext" colspan="2">
                    &quot;[{$dgOttoCategories->dgottocategories__oxgroup->value}] / [{$dgOttoCategories->dgottocategories__oxcategory->value}]&quot; Kategorie f&uuml;r die OXID Kategorie &quot;[{$oCategory->oxcategories__oxtitle->value}]&quot; anwenden
                  </td>
                </tr>
                [{/if}]
                [{if $dgOttoCategories->dgottocategories__oxtitle->value}]
                <tr>
                  <td class="edittext" colspan="3">
                    <br />der Artikeltitel der Kateorie wird in Otto so aufgebaut:<br /><br />
                    [{$dgOttoCategories->dgottocategories__oxtitle->value}] 
                  </td>
                </tr>
                [{/if}]
                <tr>
                  <td class="edittext" colspan="3"><br />
                     <button type="submit" class="edittext" name="save" onclick="showPleaseWait();this.form.aStep.value='save2Category';this.form.fnc.value='save2Category'">[{oxmultilang ident="GENERAL_SAVE"}]</button><br>
                  </td>
                </tr>
                
              </table>
            </dd>
          </dl>
         <div class="spacer"></div>
   </div>
</div> 
[{oxscript add="( function( $ ) {
    dgOttoCategory = {
        options: {},
        _create: function(){
            var self = this;
            var el   = self.element;
            el.after( '<div id=\"dgOttoCategoryResults\" class=\"search-results\" style=\"display: none;\"></div>');
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
            data: { searchparam: el.val(), cl: 'dgottocategory_search' }
          }).done(function( msg ) {
                $('#dgOttoCategoryResults').html( msg );
                $('#dgOttoCategoryResults').show();         
          });
        },
        closeSearch : function()
        {
            $(\"#dgOttoCategoryResults\").hide();       
        },
        showSearch : function()
        {
            $(\"#dgOttoCategoryResults\").show();       
        }         
    }

    $.widget( \"ui.dgOttoCategory\", dgOttoCategory );
} )( jQuery );"}]
[{oxscript add="$( document ).ready(function() { $('#dgOttoCategorySearch').dgOttoCategory(); });" priority=10}]