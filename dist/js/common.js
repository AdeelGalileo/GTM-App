var pageNo = 0;
var orderId = 0;
var sortId = 0;
var filterId = 0;
var strClass;
var strCurrId;
var strDateVal;
var columnChart;
var postDateValue;
var isLoading;

var timer = 0, perc = 0, timeTotal = 5000,  timeCount = 200, cFlag;

//var loadImg = $("<div class='text-center'> <img src='dist/img/galileo.png' class='loadImage' /> </div> ");
//$('<img />').attr('src', 'images/loading.gif').attr('class', 'loadImage');
var urlHistory = [];

$(document).ready(function() {
	 if(!$('#Messages').is(':hidden')) {
          positionPopup(false);
        $('#Messages').show();
    }
	
	 $('body').on('click', '.pop-close', function(){	
        $(this).parent('.pop-up-overlay').hide();
        document.documentElement.style.overflow = 'auto';
        document.body.scroll = "auto";
    });
	
});

function uiPopupOpen(divId, uiWidth, uiHeight){
    $('#'+divId+' .pop-up-overlay').show();
    $('#'+divId+' .pop-up-overlay .container').css('min-height', uiHeight);
    if(uiWidth >0){
        $('#'+divId+' .pop-up-overlay .container').css('width', uiWidth);
    }
    $('#'+divId+' .pop-up-overlay .container').slideDown();
    document.documentElement.style.overflow = 'hidden';
    document.body.scroll = "no";	
}

function uiPopClose(popupDivId){
    $('#'+popupDivId+' .pop-up-overlay').hide();
    document.documentElement.style.overflow = 'auto';
    document.body.scroll = "auto";
}

function MM_openBrWindow(theURL,winName,features) {
    window.open(theURL,winName,features);
}

function showPopup(msg){
    jQuery.facebox(msg, 'popupMessage');	
}

function hidePopup(){
    $('.close_image').trigger('click');
    return;
}

function autoMessage(msg){
    $('#inner_Auto').html(msg);
    $('#MessagesAuto').show();
    $('#MessagesAuto .close').show();
    hideMessageAuto(3000);
}

function hideMessageAuto(timeOut){
    if(!timeOut) timeOut = 8000;
    $('#MessagesAuto').delay(timeOut).fadeOut(1000, function(){$('#inner_Auto').html('');});
}

function positionPopup(centerWindow){
    var winX = $(window).width();
    var winY = $(window).height();
    /*var x= (winX - $('#Messages').width()) / 2 + getScrX();*/
    var x = 0;
    var y = (winY - $('#Messages').height()) / 2;
    /*var y=0;*/
    if(centerWindow){
        $('#Messages').css({'left': x+'px', 'top': y+'px'});
    } else {
        $('#Messages').css({'left': x+'px'});
    }
    hideMessage(3000);
}

function showMessage(msg){
	if(window.top == window.self) {
		$('#inner_message').html(msg);
		positionPopup(false);
		$('#Messages').show();
		$('#Messages .close').show();
		hideMessage(3000);
	} else if(parent == top){
		window.parent.autoMessage(msg);
		return;
	}
}

function hideMessage(timeOut){
    if(!timeOut) timeOut = 8000;
    $('#Messages').delay(timeOut).fadeOut(1000, function(){$('#inner_message').html('');});
}

//Check the ajax response make any redirects
function checkResponseRedirect(response){
    if(response.redirect){
		if(parent == top){
			window.parent.location = response.redirect;
			return;
		}
        if (window.top != window.self) {
            window.top.location = response.redirect;
        } else if(window.opener) {
            window.opener.location = response.redirect;
        } else if(window.parent) {
            window.parent.location = response.redirect;
        } else {
            window.location = response.redirect;
        }
    }
    return false;
}

//function to get argument from url.
function getUserParameter( name ){
    name = name.replace(/[\[]/,"\\\[").replace(/[\]]/,"\\\]");
    var regexS = "[\\?&]"+name+"=([^&#]*)";
    var regex = new RegExp( regexS );
    var results = regex.exec( window.location.href );
    if( results == null )
        return "";
    else
        return results[1];
}

/* Get Screen Width */
function getScrX() {
    var offset = 0;
    if(window.pageXOffset)
        offset = window.pageXOffset;
    else if(document.documentElement && document.documentElement.scrollLeft)
        offset = document.documentElement.scrollLeft;
    else if(document.body && document.body.scrollLeft)
        offset = document.body.scrollLeft;
    return offset;
}

/* Get Screen Height */
function getScrY() {
    var offset = 0;
    if(window.pageYOffset)
        offset = window.pageYOffset;
    else if(document.documentElement && document.documentElement.scrollTop)
        offset = document.documentElement.scrollTop;
    else if(document.body && document.body.scrollTop)
        offset = document.body.scrollTop;
    return offset;
}

function triggerReloadCommmon(){
    window.location.reload();
}

function goTrigger(){
    $(document).trigger('close.facebox');	
}

/* Validation.js*/
function validateForm(frmId){
    var hasError = false;
    var previous = '';
    var currnet = '';
    $('#'+frmId +' :input').each(function(index){
        var thisObj = $(this);
        var thisType = thisObj.attr('type');
        var elmnt = thisObj[0].nodeName;
        //Check for the element has required class
        if(index == 0){
            previous = thisObj.attr('id');	
        } else {
            previous = current;	
        }
        current = thisObj.attr('id');
        if(hasError) return;
        var parentContainer = thisObj.parent();
        //No need to check the element in hidden block
        if(parentContainer.css('display') == 'none' || thisObj.css('display') == 'none' || thisObj.is(':visible') == false || thisObj.css('visibility') == 'hidden') return;
        msg = thisObj.attr('title') ? thisObj.attr('title') : thisObj.attr('toolTip');
        if(thisObj.hasClass('requiredSelect')){
            if(thisObj.is('select')){
                if(isEmpty(thisObj.val())){
                    showMessage(msg+' Required');
                    thisObj[0].focus();
                    hasError = true;														  
                }
            }
        }
        if(thisObj.hasClass('required')){
            if(thisType == "radio"){
                if(!validateOption(thisObj.attr('name'))){
                    showMessage(msg+' Required');
                    thisObj[0].focus();
                    hasError = true;
                }
            }
            if(thisType == "checkbox"){
                if(!validateCheckBoxArray(thisObj.attr('name'))){
                    showMessage(msg+' Required');
                    thisObj[0].focus();
                    hasError = true;
                }
            }
            //Check for select box which is more than one option and value is not selected
            else if(thisObj.is('select')){
                if($('option', thisObj).length > 1 && isEmpty(thisObj.val())){
                    showMessage(msg+' Required');
                    thisObj[0].focus();
                    hasError = true;														  
                }
            }
            else if(!hasError && isEmpty(thisObj.val())){
                hasError = true;
                showMessage(msg+' Required');
                thisObj[0].focus();
            }
        }
        if(!hasError && thisObj.hasClass('email')){
            if(! validateEmail(thisObj.val())){
                showMessage('Enter valid email');
                hasError = true;
                thisObj[0].focus();
            }
        }
        if(!hasError && thisObj.hasClass('alphaNumeric')){
            if(! validateUserName(thisObj.val())){
                showMessage(msg+' should not contain any special characters');
                hasError = true;
                thisObj[0].focus();
            }
        }
        if(!hasError && thisObj.hasClass('phone')){
            if(! validatePhone(thisObj.val())){
                showMessage('Enter valid Phone');
                hasError = true;
                thisObj[0].focus();
            }
        }
        if(!hasError && thisObj.hasClass('video')) {
            if(! validateVideoURL(thisObj.val())){
                showMessage('Enter valid Youtube/Vimeo URL');
                hasError = true;
                thisObj[0].focus();
            }	
        }
        if(!hasError && thisObj.hasClass('url')){
            if(! validateUrl(thisObj.val())){
                showMessage('Enter valid URL');
                hasError = true;
                thisObj[0].focus();
            }
        }
        if(!hasError && thisObj.hasClass('integer')){
            if(! isInteger(thisObj.val())){
                showMessage('Enter valid ' + msg);
                hasError = true;
                thisObj[0].focus();
            }
        }
        if(!hasError && (thisObj.hasClass('numeric')|| thisObj.hasClass('number'))){
            if(! isNumeric(thisObj.val())){
                showMessage('Enter valid '+ msg);
                hasError = true;
                thisObj[0].focus();
            }
        }
        if(!hasError && thisObj.hasClass('imageFile')){
            if(! validateImageFileExtension(thisObj.val())){
                showMessage('Please Upload JPG/GIF/PNG file');
                hasError = true;
                thisObj[0].focus();
            }
        }
        if(!hasError && thisObj.hasClass('csvFile')){
            if(! validateCSVFileExtension(thisObj.val())){
                showMessage('Please Upload CSV file');
                hasError = true;
                thisObj[0].focus();
            }
        }
        if(!hasError && thisObj.hasClass('textboxValue')){
            if(thisObj.val()==''){
                showMessage('Please enter the Folder Name');
                hasError = true;
                thisObj[0].focus();
            }
        }
        if(!hasError && thisObj.hasClass('existingPassword')){
            var strCurrPassword = $('#'+current).val();

            if(!checkPassword_length(strCurrPassword)){
                showMessage("Password must contain at least eight characters");
                hasError = true;
                thisObj[0].focus();
            } else if(!checkPassword_Number(strCurrPassword)){
                showMessage("Password must contain at least one number (0-9)");
                hasError = true;
                thisObj[0].focus();
            } else if(!checkPassword_LowerCase(strCurrPassword)){
                showMessage("Password must contain at least one lowercase letter (a-z)");
                hasError = true;
                thisObj[0].focus();
            } else if(!checkPassword_UpperCase(strCurrPassword)){
                showMessage("Password must contain at least one uppercase letter (A-Z)");
                hasError = true;
                thisObj[0].focus();
            } else if(!checkPassword_SpecialChars(strCurrPassword)){
                showMessage("Password must contain at least one special characters");
                hasError = true;
                thisObj[0].focus();
            }
        }
        if(!hasError && thisObj.hasClass('existing')){
            var strCurrPassword = $('#'+current).val();

            if(!checkPassword_length(strCurrPassword)){
                showMessage("Password must contain at least eight characters");
                hasError = true;
                thisObj[0].focus();
            } else if(!checkPassword_Number(strCurrPassword)){
                showMessage("Password must contain at least one number (0-9)");
                hasError = true;
                thisObj[0].focus();
            } else if(!checkPassword_LowerCase(strCurrPassword)){
                showMessage("Password must contain at least one lowercase letter (a-z)");
                hasError = true;
                thisObj[0].focus();
            } else if(!checkPassword_UpperCase(strCurrPassword)){
                showMessage("Password must contain at least one uppercase letter (A-Z)");
                hasError = true;
                thisObj[0].focus();
            } else if(!checkPassword_SpecialChars(strCurrPassword)){
                showMessage("Password must contain at least one special characters");
                hasError = true;
                thisObj[0].focus();
            }
            if(!compareExisting($('#'+previous).val(), $('#'+current).val())){
                var prevMsg = $('#'+previous).attr('title') ? $('#'+previous).attr('title') : $('#'+previous).attr('toolTip');
                var currentMsg = $('#'+current).attr('title') ? $('#'+current).attr('title') : $('#'+current).attr('toolTip');
                showMessage(prevMsg + ' and ' +  currentMsg + ' cannot be the same');
                hasError = true;
                thisObj[0].focus();
            }
        }
        if(!hasError && thisObj.hasClass('equal')){
            if(!compareEqual($('#'+previous).val(), $('#'+current).val())){
                var prevMsg = $('#'+previous).attr('title') ? $('#'+previous).attr('title') : $('#'+previous).attr('toolTip');
                var currentMsg = $('#'+current).attr('title') ? $('#'+current).attr('title') : $('#'+current).attr('toolTip');
                showMessage(prevMsg + ' and ' +  currentMsg + ' must be the same');
                hasError = true;
                thisObj[0].focus();
            }
        }
    });
    return hasError;
}

function checkPassword_length(strCurrPassword){
    if(strCurrPassword.length < 8)
        return false;
    else
        return true;
}

function checkPassword_Number(strCurrPassword){
    var testNumber = /[0-9]/;
    if(!testNumber.test(strCurrPassword))
        return false;
    else
        return true;
}

function checkPassword_LowerCase(strCurrPassword){
    var testLower = /[a-z]/;
    if(!testLower.test(strCurrPassword))
        return false;
    else
        return true;
}

function checkPassword_UpperCase(strCurrPassword){
    var testUpper = /[A-Z]/;
    if(!testUpper.test(strCurrPassword))
        return false;
    else
        return true;
}

function checkPassword_SpecialChars(strCurrPassword){
    var testSpecial =  /[._!@#$%^&*()+=]/;
    if(!testSpecial.test(strCurrPassword))
        return false;
    else
        return true;
}

function validateEmail(str){
    str = $.trim(str);
    if(isEmpty(str)) return true;
    regex = /^[a-zA-Z0-9._-]+@([a-zA-Z0-9.-]+\.)+[a-zA-Z0-9.-]{2,8}$/;
    return (regex.test(str));
}

function validateUrl(url){
    return url.match(/^(ht|f)tps?:\/\/[a-z0-9-\.]+\.[a-z]{2,4}\/?([^\s<>\#%"\,\{\}\\|\\\^\[\]`]+)?$/);	
}

function validateOption(radName){
    var radios = document.getElementsByName(radName);
    for(cnt = 0; cnt < radios.length; cnt++){
        if(radios[cnt].checked) 
            return true;
    }
    return false;
}

function validateCheckBoxArray(checkBoxName){
    var valid = false;
    var checkBoxArray = $(':input[name^='+checkBoxName+']');
    checkBoxArray.each(function(){
        if($(this)[0].checked){
            valid = true;
        }
    })
    return valid;
}

function compareExisting(str1, str2){
    if(str1 == str2)
        return false;
    else
        return true;
}

function compareEqual(str1, str2){
    if(str1 == str2)
        return true;
    else
        return false;
}

function isEmpty(str){
    if($.trim(str) == ''){
        return true;
    }
    return false;
}

function isValid(obj){
    if($.trim(obj.val()) == ''){
        return false;
    }
    return true;
}

function isInteger(obj){
    value = $.trim(obj);
    if(isEmpty(value)) return true;
    var regex = /^(\-|\+)?(\d+)$/;
    return (regex.test(value));
}

function isNumeric(obj) {
    value = $.trim(obj);
    if(isEmpty(value)) return true;
    var regex =/^(\-|\+)?[0-9]+(\.[0-9]+)?$/;
    return (regex.test(value));
}

function isPositive(obj) {
    value = $.trim(obj);
    if(isEmpty(value)) return true;
    var regEx =/^(\-|\+)?[0-9]+(\.[0-9]+)?$/;
    return (regex.test(value));
}

function checkDate(year, month, day){
    var d = new Date();
    month -= 1;
    d.setFullYear(year, month, day);
    return (d.getDate() == day && d.getMonth() == month && d.getFullYear() == year);
}

function validateYoutubeUrl(url){
    regex=/^http:\/\/www.youtube.com\//;
}

function stripCharsInBag(s, bag){
    var i;
    var returnString = "";
    // Search through string's characters one by one.
    // If character is not in bag, append to returnString.
    for (i = 0; i < s.length; i++){   
        // Check that current character isn't whitespace.
        var c = s.charAt(i);
        if (bag.indexOf(c) == -1) returnString += c;
    }
    return returnString;
}

function checkInternationalPhone(strPhone) {
    // Declaring required variables
    var digits = "0123456789";
    // non-digit characters which are allowed in phone numbers
    var phoneNumberDelimiters = "()- ";
    // characters which are allowed in international phone numbers
    // (a leading + is OK)
    var validWorldPhoneChars = phoneNumberDelimiters + "+";
    // Minimum no of digits in an international phone no.
    var minDigitsInIPhoneNumber = 10;
    var bracket = 3;
    strPhone = $.trim(strPhone);
    if(strPhone.indexOf("+")>1) return false;
    if(strPhone.indexOf("-")!=-1)bracket=bracket+1;
    if(strPhone.indexOf("(")!=-1 && strPhone.indexOf("(")>bracket)return false;
    var brchr=strPhone.indexOf("(");
    if(strPhone.indexOf("(")!=-1 && strPhone.charAt(brchr+2)!=")")return false;
    if(strPhone.indexOf("(")==-1 && strPhone.indexOf(")")!=-1)return false;
    s = stripCharsInBag(strPhone,validWorldPhoneChars);
    return (isInteger(s) && s.length >= minDigitsInIPhoneNumber);
}

function validatePhone(Phone){
    if (checkInternationalPhone(Phone)==false){
        return false;
    }
    return true;
}

function validateImageFileExtension(fileName){
    var validExtension = /(.jpg|.jpeg|.gif|.png)$/i;   
    return (validExtension.test(fileName))
}

function validateCSVFileExtension(fileName){
    var validExtension = /(.csv)$/i;   
    return (validExtension.test(fileName))
}

function validateUserName(userName){
    str = $.trim(userName);
    if(isEmpty(userName)) return true;
    var regUserName = /^([0-9a-zA-Z\-_ ]+)$/;
    return (regUserName.test(userName));
}

function validateVideoURL(str){
    str = $.trim(str);
    if(isEmpty(str)) return true;
    youtube = /http:\/\/www\.youtube.com\//;
    if(youtube.test(str)){
        if(/embed/.test(str)){
            return true;	
        } else if(/watch\?v=([^?&]*)/.test(str)){
            return true;
        }
    }
    vimeo = /http:\/\/(www\.)?vimeo.com\//;
    if(vimeo.test(str)){
        return true;	
    }
    brightcove = /[0-9]{10,}/
    if(brightcove.test(str)){
        return true;	
    }
    return false;
}

function trim(str){
    if(!str || typeof str != 'string')
	return null;
    return str.replace(/^[\s]+/,'').replace(/[\s]+$/,'').replace(/[\s]{2,}/,' ');
}

function validate(email) {
    var reg = /^([A-Za-z0-9_\-\.])+\@([A-Za-z0-9_\-\.])+\.([A-Za-z]{2,4})$/;
    if(reg.test(email) == false) { 
        showMessage('Invalid Email Address');
       return false;
    } else {
            return true;
    }
}

function cleatTextArea(thefield) {
    if (thefield.defaultValue==thefield.value)
    thefield.value = ""
}


function getDateRange(rangeVal){
    var weekDays;
    /*if(rangeVal ==0) return;*/
    if(rangeVal == 1) {
        weekDays = [new Date(), new Date()];
    } else if(rangeVal == 2) {
        weekDays = getLastWeekDays();
    } else if(rangeVal == 3) {
        weekDays = getLastMonth();
    } else if(rangeVal == 4) {
        weekDays = getLastYear();
    } else if(rangeVal == 5) {
        var d = new Date();
        d.setMonth(d.getMonth() - 2);
        weekDays = [d, new Date()];
    }
    $('#fromDate').datepicker("setDate",weekDays[0]);
    $('#toDate').datepicker("setDate",weekDays[1]);
}

function getCurrentWeekDays(){
    var curr = new Date; // get current date
    var first = curr.getDate() - curr.getDay(); 
    var last = first + 6; // last day is the first day + 6
    var firstday = new Date(curr.setDate(first));
    var lastday = new Date(curr.setDate(last));
    return [firstday, lastday];
}

function getLastWeekDays(){
    var curr = new Date; // get current date
    /*var first = curr.getDate() - curr.getDay() - 7; */ //Get first date of last week
    var first = curr.getDate() - 7;
    var last = first + 6; // last day of the last week
    if(first <= 0){
        var month = curr.getMonth();
        var year = curr.getFullYear();
        var lastday = new Date(year, month, last);
    } else {
        var lastday = new Date(curr.setDate(last));	
    }
    var firstday = new Date(curr.setDate(first));
    return [firstday, lastday];	
}

function getLastMonth(){
    var curr = new Date; // get current date
    var first = curr.getDate() - 1;
    /*var firstOfMonth = new Date(curr.getFullYear(), curr.getMonth()-1, 1);
    var lastOfMonth = new Date( curr.getFullYear(), curr.getMonth(), 0 );*/
    var firstOfMonth = new Date(curr.getFullYear(), curr.getMonth()-1, first);
    var lastOfMonth = new Date( curr.getFullYear(), curr.getMonth(), first );
    return [firstOfMonth, lastOfMonth];	
}

function getLastYear(){
    var curr = new Date; // get current date
    /*var firstOfYear = new Date(curr.getFullYear()-1, 0, 1);
    var lastOfYear = new Date( curr.getFullYear()-1, 11, 31);*/
    var first = curr.getDate() - 1;
    var firstOfYear = new Date(curr.getFullYear()-1, curr.getMonth(), first);
    var lastOfYear = new Date( curr.getFullYear(), curr.getMonth(), first);
    return [firstOfYear, lastOfYear];	
}


function getCheckBoxValuesForLeadsPage(className){
    var checkValue = [];
    $(className).each(function(){
        if($(this).prop('checked')){
            checkValue.push($(this).val());
        }
    })
    return checkValue;
}

function getCheckBoxTextForLeadsPage(className){
    var checkValue = [];
    $(className).each(function(){
        if($(this).prop('checked')){
            checkValue.push($(this).next('span').text());
        }
    })
    return checkValue;
}


function closeIframe() {
    try {
        $('#div_openData').dialog('close');
    } catch(ex){
        $('#div_openData .pop-close').trigger('click');
    }
    return false;
}



function getChartIntervalForDate(data){
    dateCount = data.length;
    var tickInterval = 1*24*3600*1000;
    if(dateCount > 90){
        tickInterval = 30*24*3600*1000;
    } else if(dateCount > 60){
        tickInterval = 14*24*3600*1000;
    } else if(dateCount > 14){
        tickInterval = 7*24*3600*1000;
    }
    return tickInterval;
}


function getCookie(name){
    var nameEQ = name + "=";
    var ca = document.cookie.split(';');
    for(var i=0;i < ca.length;i++) {
        var c = ca[i].trim();
        if (c.indexOf(nameEQ) == 0) return c.substring(nameEQ.length,c.length);
    }
    return null;
}

function del_cookie(name) {
    var now = new Date();
    now.setMonth( now.getMonth() - 1 ); 
    document.cookie =name +'=;expires=' + now.toUTCString() + ";"
}


function PageChange(Pageval){
    var strFilterId = $('#filterId').val();
    var recCount = Pageval;
    $('#recCount').val(recCount);
    $('#recCountNew').val(recCount);
    pageNo = 0;
}

function formatDate(dateStr)
{
  function pad(s) { return (s < 10) ? '0' + s : s; }
  var dateParts = dateStr.split(' ');
  var sysDate = dateParts[0].split('-');
  var d = new Date(sysDate[0], sysDate[1]-1, sysDate[2]);
  return [pad(d.getMonth()+1), pad(d.getDate()), d.getFullYear()].join('/');
}


function getHost(url)
{
    var a = document.createElement('a');
    a.href = url;
    return a.origin+a.pathname;
}

truncateString = function(firstName, lastName, length, ending)
{
	var str;
	if(firstName==null){
		firstName = '';	
	}
	if(lastName==null){
		lastName = '';	
	}
	if(ending == null){
		ending = '&hellip;'
	}
	if(length == null){
		length = 30;	
	}
	str = $.trim(firstName + ' '+ lastName);
	if (str.length > length) {
      return str.substring(0, length - ending.length) + ending;
    } else {
      return str;
    }
}
