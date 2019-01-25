// JavaScript Document

$(document).ready(function () {
    showHideBenefits();
    $("#txtDescription").keypress(function (event) {
        if ($(this).val().length > 1999) {
            return false;
        }
        return true;
    });
    setVisiblityOfDutiesRemoveButton();
    setVisiblityOfQualificationRemoveButton();
    setVisiblityOfBenefitRemoveButton();
    $(".bCancel").click(function () {
        window.location = "career.aspx";
    });
    $(".bSave").click(function () {
        save();
    });
    $('input[type=radio]').click(function () {
        showHideBenefits();
    });

    $(".dutiesMainItem").has("ul").has("li").find("input:checkbox").prop("checked", true);
    $(".qualificationMainItem").has("ul").has("li").find("input:checkbox").prop("checked", true);
    $(".benefitsMainItem").has("ul").has("li").find("input:checkbox").prop("checked", true);
});

function showHideBenefits() {
    if ($('input[type=radio]:checked').val() == 1) {
        $("#benReq").show();
    }
    else {
        $("#benReq").hide();
    }
}
function setVisiblityOfDutiesRemoveButton() {
    var count = $(".dutiesMainItem").length;
    if (parseInt(count) == 1) {
        $(".dutiesMainItem").find(".rbtn").hide();
    }
    else {
        $(".dutiesMainItem").find(".rbtn").show();
    }
}
function setVisiblityOfQualificationRemoveButton() {
    var count = $(".qualificationMainItem").length;
    if (parseInt(count) == 1) {
        $(".qualificationMainItem").find(".rbtn").hide();
    }
    else {
        $(".qualificationMainItem").find(".rbtn").show();
    }
}
function setVisiblityOfBenefitRemoveButton() {
    var count = $(".benefitsMainItem").length;
    if (parseInt(count) == 1) {
        $(".benefitsMainItem").find(".rbtn").hide();
    }
    else {
        $(".benefitsMainItem").find(".rbtn").show();
    }
}


function addMainListItemDT(obj) {
    var count = 0;
    var ele = null;
    $(obj).parent().parent().find($('.mainItem')).each(function() {
        if ($(this).val() === "") {
            count++;
            ele = $(this);
            return false;
        }
    });
    if (count == 0) {
        $(obj).parent().after('<li class="dutiesMainItem"><input maxlength="500" onkeyup="onKeyUpValidate(event,this);" type="text" itemType="1" class="mainItem textBox"/>&nbsp;<input type="checkbox" onclick="ChkBoxSelect(this)" title="Add Sublist" />&nbsp;<a href="javascript:void(0)" onclick="addMainListItemDT(this);"><img src="images/career/add-list-icon.png" alt="Add List Item" title="Add List Item" /></a>&nbsp;&nbsp;<a href="javascript:void(0)" class="rbtn" onclick="removeList(this)"><img src="images/career/remove-icon.png" alt="Remove List Item" title="Remove List Item" /></a></li>');
        setVisiblityOfDutiesRemoveButton();
    } else {
        alert('To add more lists, first fill all the empty lists.');
        ele.focus();
    }
}	

		
function addMainListItemQF(obj) {
    var count = 0;
    var ele = null;
    $(obj).parent().parent().find($('.mainItem')).each(function() {
        if ($(this).val() === "") {
            count++;
            ele = $(this);
            return false;
        }
    });
    if (count == 0) {
        $(obj).parent().after('<li class="qualificationMainItem" ><input maxlength="500" onkeyup="onKeyUpValidate(event,this);" type="text" class="mainItem textBox" itemType="2" />&nbsp;<input type="checkbox" onclick="ChkBoxSelect(this)" title="Add Sublist" />&nbsp;<a href="javascript:void(0)" onclick="addMainListItemQF(this);"><img src="images/career/add-list-icon.png" alt="Add List Item" title="Add List Item" /></a>&nbsp;&nbsp;<a href="javascript:void(0)" class="rbtn"  onclick="removeList(this)"><img src="images/career/remove-icon.png" alt="Remove List Item" title="Remove List Item" /></a></li>');
        setVisiblityOfQualificationRemoveButton();
    } else {
        alert('To add more lists, first fill all the empty lists.');
        ele.focus();
    }
	
}

function addMainListItemBF(obj) {
    var count = 0;
    var ele = null;
    $(obj).parent().parent().find($('.mainItem')).each(function() {
        if ($(this).val() === "") {
            count++;
            ele = $(this);
            return false;
        }
    });
	if (count == 0) {
	    $(obj).parent().after('<li class="benefitsMainItem"><input maxlength="500" onkeyup="onKeyUpValidate(event,this);" class="mainItem textBox" type="text" itemType="3"/>&nbsp;<input type="checkbox" onclick="ChkBoxSelect(this)" title="Add Sublist" />&nbsp;<a href="javascript:void(0)" onclick="addMainListItemBF(this);"><img src="images/career/add-list-icon.png" alt="Add List Item" title="Add List Item" /></a>&nbsp;&nbsp;<a href="javascript:void(0)" class="rbtn"  onclick="removeList(this)"><img src="images/career/remove-icon.png" alt="Remove List Item" title="Remove List Item" /></a></li>');
		setVisiblityOfBenefitRemoveButton();
	} else {
	alert('To add more lists, first fill all the empty lists.');
	ele.focus();
	}
}

function removeList(obj) {
    $(obj).parent().remove();
    if ($(obj).parent().attr('class') === "dutiesMainItem") {
        setVisiblityOfDutiesRemoveButton();
    } else if ($(obj).parent().attr('class') === "qualificationMainItem") {
        setVisiblityOfQualificationRemoveButton();
    } else if ($(obj).parent().attr('class') === "benefitsMainItem") {
        setVisiblityOfBenefitRemoveButton();
    }
}

function removeSubItem(obj) {   
    var subItemCount = $(obj).parent().parent().parent().find("li").length;    
    if (parseInt(subItemCount) > 1) {
        $(obj).parent().parent().remove();
    }
    else {
        $(obj).parent().parent().parent().parent().find("input:checkbox").prop("checked", false);
        $(obj).parent().parent().parent().remove();       
    }
}
		
function ChkBoxSelect(obj){
    if ($(obj).parent().find(".textBox").val() != '') {
        if ($(obj).is(':checked')) {
            if ($(obj).parent().attr("class") === "dutiesMainItem") {
                $(obj).parent().append('<ul class="sublists"><li class="subDuties"><input maxlength="500" onkeyup="onKeyUpValidate(event,this);" type="text" class="subItem textBox" itemType="1"/>&nbsp;&nbsp;<a href="javascript:void(0)" onclick="dBtnClick(this);"><img src="images/career/add-sublist-icon.png" alt="Add Sublist Item" title="Add Sublist Item" /></a>&nbsp;&nbsp;<a href="#"><img src="images/career/remove-icon.png" alt="Remove Sublist Item" class="subRbtn" onclick="removeSubItem(this);" title="Remove Sublist Item" /></a></li></ul>');
            } else if ($(obj).parent().attr("class") === "qualificationMainItem") {
            $(obj).parent().append('<ul class="sublists"><li class="subQualifications"><input maxlength="500" onkeyup="onKeyUpValidate(event,this);" type="text" class="subItem textBox" itemType="2" />&nbsp;&nbsp;<a href="javascript:void(0)" onclick="qBtnClick(this);"><img src="images/career/add-sublist-icon.png" alt="Add Sublist Item" title="Add Sublist Item" /></a>&nbsp;&nbsp;<a href="#"><img src="images/career/remove-icon.png" alt="Remove Sublist Item" class="subRbtn" onclick="removeSubItem(this);" title="Remove Sublist Item" /></a></li></ul>');
            }
            else if ($(obj).parent().attr("class") === "benefitsMainItem") {
            $(obj).parent().append('<ul class="sublists"><li class="subBenefits"><input maxlength="500" onkeyup="onKeyUpValidate(event,this);" itemType="3" type="text" class="subItem textBox" />&nbsp;&nbsp;<a href="javascript:void(0)" onclick="bBtnClick(this);"><img src="images/career/add-sublist-icon.png" alt="Add Sublist Item" title="Add Sublist Item" /></a>&nbsp;&nbsp;<a href="#"><img src="images/career/remove-icon.png" alt="Remove Sublist Item" class="subRbtn" onclick="removeSubItem(this);" title="Remove Sublist Item" /></a></li></ul>');
            }
        } else {
            $(obj).parent().find("ul").remove();
            return false;
        }
    } else {
        alert('To add Sub list, first fill the Main list.');
        $(obj).prop("checked", false);
        $(obj).parent().find(".textBox").focus();
        return false;
    }
	        
}

function dBtnClick(obj) {
    var count = 0;
    var ele = null;
    $(obj).parent().parent().find($('.subItem')).each(function() {
        if ($(this).val() === "") {
            count++;
            ele = $(this);
            return false;
        }
    });  
    if (count == 0) {
        $(obj).parent().after('<li class="subDuties"><input maxlength="500" onkeyup="onKeyUpValidate(event,this);" itemType="1" type="text" class="subItem textBox" />&nbsp;&nbsp;<a href="javascript:void(0)" onclick="dBtnClick(this);"><img src="images/career/add-sublist-icon.png" alt="Add Sublist Item" title="Add Sublist Item" /></a>&nbsp;&nbsp;<a href="#"><img src="images/career/remove-icon.png" class="subRbtn" onclick="removeSubItem(this);" alt="Remove Sublist Item" title="Remove Sublist Item" /></a></li>')
    }
    else {
        alert('To add more list item, first fill this list item.');
        ele.focus();
    }
	
}

function qBtnClick(obj) {
    var count = 0;
    var ele = null;
    $(obj).parent().parent().find($('.subItem')).each(function() {
        if ($(this).val() === "") {
            count++;
            ele = $(this);
            return false;
        }
    });
    if (count == 0) {
        $(obj).parent().after('<li class="subQualifications"><input maxlength="500" onkeyup="onKeyUpValidate(event,this);" itemType="2" type="text" class="subItem textBox" />&nbsp;&nbsp;<a href="javascript:void(0)" onclick="qBtnClick(this);"><img src="images/career/add-sublist-icon.png" alt="Add Sublist Item" title="Add Sublist Item" /></a>&nbsp;&nbsp;<a href="#"><img src="images/career/remove-icon.png" class="subRbtn" onclick="removeSubItem(this);" alt="Remove Sublist Item" title="Remove Sublist Item" /></a></li>')
	}
	else {
	    alert('To add more list item, first fill this list item.');
	    ele.focus();
	}
}

function bBtnClick(obj) {
    var count = 0;
    var ele = null;
    $(obj).parent().parent().find($('.subItem')).each(function() {
        if ($(this).val() === "") {
            count++;
            ele = $(this);
            return false;
        }
    });
    if (count == 0) {
        $(obj).parent().after('<li class="subBenefits"><input maxlength="500" onkeyup="onKeyUpValidate(event,this);" itemType="3" type="text" class="subItem textBox" />&nbsp;&nbsp;<a href="javascript:void(0)" onclick="bBtnClick(this);"><img src="images/career/add-sublist-icon.png" alt="Add Sublist Item" title="Add Sublist Item" /></a>&nbsp;&nbsp;<a href="#"><img src="images/career/remove-icon.png" class="subRbtn" onclick="removeSubItem(this);" alt="Remove Sublist Item" title="Remove Sublist Item" /></a></li>')
    } else {
    alert('To add more list item, first fill this list item.');
    ele.focus();
    }
}

//////////////////-----Saving Data--------------------------///////////

function save() {

    if (!validate()) {
        return;
    } 
                var objJob = new Object();
                objJob.JobTitle = $("#jobTitle").val();
                objJob.InActive = $("#chkActive").is(":checked") ? 0: 1;
                objJob.LocationID = $('input[type=radio]:checked').val();
                objJob.StateID = 0;
                objJob.Description = escape($("#txtDescription").val().replace(/\n/g, '<br/>'));               

                objJob.JobDetail = new Array();            
           
                var mainCount = $('.mainItem').length;
                if (mainCount > 0) {
                    $('.mainItem').each(function (index) {
                        var mainItem = new Object();    
                        var item = $(this);                    
                        mainItem.Name = item.val();
                        mainItem.JobAttributeID = item.attr('itemType');                        
                        mainItem.subItems = new Array();
                        var subItemCount = item.parent().find('.subItem').length;
                        if(subItemCount > 0)
                        {
                            item.parent().find('.subItem').each(function(index){
                                var subItem = new Object();                                 
                                subItem.Name = $(this).val();
                                subItem.JobAttributeID = $(this).attr('itemType');
                                mainItem.subItems.push(subItem);
                            });                           
                        }
                        objJob.JobDetail.push(mainItem);                       
                    });
                }
          var objJobManager = new Job();
          var JobID = $("#hdnJobID").val();
          objJobManager.AddJobDetails(Sys.Serialization.JavaScriptSerializer.serialize(objJob), JobID);
}

function Job() { }

Job.prototype =
        {
            AddJobDetails: function(objJob, JobId) {                
                $(".bSave").attr('disabled', true);    
                $.post("CallBacks/JobHandler.aspx", { Job: escape(objJob), JobId: JobId }, function(response) {                    
                    if (response.indexOf("Success") != -1) {

                            window.location = "career.aspx";
                    }else{


                    $(".bSave").attr('disabled', false);    
                    }           
                });
            }
        }

        ///////////////////------------------End Saving Data--------------------------//////////////

        /////----------------------Code For Validating Form ----------------------------//////////////////////

        function onKeyUpValidate(e, obj) {
            var key = e.keyCode || e.charCode;
            if ($(obj).attr("id") === "txtDescription") {
                if ($(obj).val().length > 1999) {
                    $(obj).val($(obj).val().substr(0, 2000));                    
                }
            }
            if (key == 13) {
                $('#btnSubmit').click(); return false;
            }
            else {                
                $(obj).siblings("span").remove();
                return false;
            }
        }       

        function validate() {            
            var id = null;
            $("input[type=text], textarea").each(function() {
                var field = $(this);
                field.parent().find("span").remove();
                RemoveHtmlTags(field);
                field.val(jQuery.trim(field.val()));
                if (field.attr("id") === "jobTitle" && field.val() === "") {
                    showErrorMsg(field, "Please enter job title", false);
                    if (id == null) {
                        id = field;
                    }
                }
                else if (field.attr("id") === "jobTitle" && !isAlphaNumeric(field.val())) {
                    showErrorMsg(field, "Please enter valid job title", false);
                    if (id == null) {
                        id = field;
                    }
                }
                else if (field.attr("id") === "txtDescription" && field.val() === "") {

                    showErrorMsg(field, "Please enter job description", false);
                    if (id == null) {
                        id = field;
                    }
                }
                else if (field.parent().attr("class") === "dutiesMainItem" && field.val() === "") {
                    showErrorMsg(field, "Please enter duties and responsibilities", false);
                    if (id == null) {
                        id = field;
                    }
                }
                else if (field.parent().attr("class") === "qualificationMainItem" && field.val() === "") {
                    showErrorMsg(field, "Please enter qualification", false);
                    if (id == null) {
                        id = field;
                    }
                }
                else if (field.parent().attr("class") === "benefitsMainItem" && field.val() === "" && $('input[type=radio]:checked').val() == 1) {
                    showErrorMsg(field, "Please enter benefits", false);
                    if (id == null) {
                        id = field;
                    }
                }
                else if (field.parent().parent().parent().attr("class") === "dutiesMainItem" && field.val() === "") {
                    showErrorMsg(field, "Please enter duties and responsibilities", false);
                    if (id == null) {
                        id = field;
                    }
                }
                else if (field.parent().parent().parent().attr("class") === "qualificationMainItem" && field.val() === "") {
                    showErrorMsg(field, "Please enter qualification", false);
                    if (id == null) {
                        id = field;
                    }
                }
                else if (field.parent().parent().parent().attr("class") === "benefitsMainItem" && field.val() === "" && $('input[type=radio]:checked').val() == 1) {
                    showErrorMsg(field, "Please enter benefits", false);
                    if (id == null) {
                        id = field;
                    }
                }
            });
            if (id == null) {
                return true;
            }
            else {
                $(id).focus();
                ScrollToElement($(id));
                return false;
            }
        }


        function showErrorMsg(Control, ErrrorMessage, scroll) {

            if ($(Control).attr("itemType") === "1" || $(Control).attr("itemType") === "2" || $(Control).attr("itemType") === "3") {

                if ($(Control).parent().find("ul").attr("class") === "sublists") {
                    $(Control).parent().find("ul").before("<Span class='ValidationErrors'>" + ErrrorMessage + "</Span>");
                }
                else {
                    $(Control).parent().append("<Span class='ValidationErrors'>" + ErrrorMessage + "</Span>");
                }
            }
            else if ($(Control).attr("class") === "subItem textBox") {
                $(Control).parent().append("<Span class='ValidationErrors'>" + ErrrorMessage + "</Span>");
            }
            else {
                $(Control).after("<Span class='ValidationErrors'>" + ErrrorMessage + "</Span>");
            }
        }
        function ScrollToElement(el) {
            try {
                $('html, body').animate({ scrollTop: $(el).offset().top - 50 }, 'slow');
            }
            catch (err) {

            }
        }
        function isValidEmailAddress(emailAddress) {
            var pattern = new RegExp(/^(("[\w-+\s]+")|([\w-+]+(?:\.[\w-+]+)*)|("[\w-+\s]+")([\w-+]+(?:\.[\w-+]+)*))(@((?:[\w-+]+\.)*\w[\w-+]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$)|(@\[?((25[0-5]\.|2[0-4][0-9]\.|1[0-9]{2}\.|[0-9]{1,2}\.))((25[0-5]|2[0-4][0-9]|1[0-9]{2}|[0-9]{1,2})\.){2}(25[0-5]|2[0-4][0-9]|1[0-9]{2}|[0-9]{1,2})\]?$)/i);
            return pattern.test(emailAddress);
        }

        function isAlphaOnly(val) {
            var pattern = new RegExp("^[a-zA-Z.&(),' -]*$");
            return pattern.test(val);
        }

        function isAlphaNumeric(val) {
            var pattern = new RegExp("^[a-zA-Z0-9.&(),' -]*$");
            return pattern.test(val);
        }

        function RemoveHtmlTags(id) {
            val = $(id).val();
            $(id).val(val.replace(/<(.|\n)*?>/g, ''));
        }


       
        //////------End Validation --------------------------////////////////////
