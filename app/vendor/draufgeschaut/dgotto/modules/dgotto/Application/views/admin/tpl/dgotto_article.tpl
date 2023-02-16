<div class="groupExp">
   <div [{if $aStep == "save2Category" || !$dgOttoCategories}] class="exp"[{/if}]>
        <a href="#" onclick="_groupExp(this);return false;" class="rc"><b>Artikel &quot;[{$edit->oxarticles__oxtitle->value|truncate:30}]&quot; zu Otto Kategorie zuordnen ?</b></a>
          <dl>
            <dd>
              <table cellspacing="0" cellpadding="0" border="0">
                <tr>
                  <td class="edittext">
                    <span style="color:#D4021D;font-weight: 800;font-size: 12px;">OTTO</span> Kategorie
                  </td>
                  <td class="edittext">
                    <input id="dgOttoCategorySearch" name="editval[dgottocategory]" value="[{$oView->getOttoCategory($edit)}]" type="text" size="40" />
                    <input id="dgOttoCategorySearchId" name="editval[dgottocategoryid]" value="[{$oView->getOttoCategoryId($edit)}]" type="hidden" />
                    <input id="dgOttocategory" name="editval[dgottocategory]" value="[{$oViewConf->getTopActiveClassName()}]" type="hidden" />
                  </td>
                  <td class="edittext">
                  </td>
                </tr>
                <tr>
                  <td class="edittext">
                    gew&auml;hlt:
                  </td>
                  <td class="edittext" colspan="2">
                    [{$dgOttoCategories->dgottocategories__oxgroup->value}] / [{$dgOttoCategories->dgottocategories__oxcategory->value}] 
                  </td>
                </tr>
                [{if !$dgOttoCategories}]
                <tr>
                  <td class="edittext" colspan="3"><br /><br />
                     <button type="submit" class="edittext" name="save" onclick="showPleaseWait();this.form.aStep.value='save2Category';this.form.fnc.value='save2Category'">[{oxmultilang ident="GENERAL_SAVE"}]</button><br>
                  </td>
                </tr>
                [{/if}]
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
            url: el.parents(\"form[name=transfer]\").attr(\"action\"),
            data: { searchparam: el.val(), cl: \"dgottocategory_search\" }
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