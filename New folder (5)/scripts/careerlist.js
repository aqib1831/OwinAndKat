function ShowDetail(id, backToPage) {
    parent.window.location = 'RnDMain.aspx?IdeaId=' + id + '&backToPage=' + backToPage;
}

function ChangeRowsClass() {
    var element = getElementByClassName('gvwSilverFooter');
    if (element != null) {
        element.className = 'gvwSilverFooterOdd';
    }
}

function SetRowStyle() {
    var element = getElementByClassName('gvwSilverFooterOdd');
    if (element != null) {
        element.className = 'gvwSilverFooter';
    }
}

AdjustPagerRow();

function AdjustPagerRow() {
    var objTag = null;
    var objCustomRow = null;
    try {
        trPager.style.display = 'inline';
        objCustomRow = getElement("tdPager");
        objTag = getElementByClassName("gvwSilverPager");
        objCustomRow.innerHTML = '&nbsp;';
        if (objTag != null && objCustomRow != null) {
            var objPagerHTML = getElement('tblPager').outerHTML;
            objCustomRow.innerHTML = objPagerHTML;
            objCustomRow.className = "cpygvwSilverPager";
            objTag.style.display = 'none';
        }
        else {
            //if the pager has not been displayed hide the row.
            trPager.style.display = 'none';
        }
    } catch (ex) {
        //alert("Javascript Error:\n"+ex.description);
    }
}



function beginRequest(sender, args) {
    postbackElement = args.get_postBackElement();
}

function endRequest(source, args) {
    setSequenceButtons();
}
function onPageLoading(sender, e) {
}

function SetDefaultButton() {
    __defaultFired = false;
}

function onSeqUpClick(obj) {
    if ($(obj).attr("class") === "seqUpActive") {
        var prevRow = $(obj).parent().parent().prev("tr");
        var currentRow = $(obj).parent().parent();
        var newSeqOfUpperRow = currentRow.find("#spnSeqNo").text();
        currentRow.find("#spnSeqNo").text(prevRow.find("#spnSeqNo").text());
        prevRow.find("#spnSeqNo").text(newSeqOfUpperRow);
        var lastRow = prevRow.html();
        var thisRow = currentRow.html();
        prevRow.html(thisRow);
        currentRow.html(lastRow);
        setSequenceButtons();
        var values = prevRow.find("#jobId").text() + "-" + prevRow.find("#spnSeqNo").text() + ", " + currentRow.find("#jobId").text() + "-" + currentRow.find("#spnSeqNo").text();
        updateSeq(values);
    }
}

function onSeqDownClick(obj) {
    if ($(obj).attr("class") === "seqDownActive") {
        var nextRow = $(obj).parent().parent().next("tr");
        var currentRow = $(obj).parent().parent();
        var newSeqOfNextRow = currentRow.find("#spnSeqNo").text();
        currentRow.find("#spnSeqNo").text(nextRow.find("#spnSeqNo").text());
        nextRow.find("#spnSeqNo").text(newSeqOfNextRow);
        var nextRowHtml = nextRow.html();
        var thisRowHtml = currentRow.html();
        nextRow.html(thisRowHtml);
        currentRow.html(nextRowHtml);
        setSequenceButtons();
        var values = nextRow.find("#jobId").text() + "-" + nextRow.find("#spnSeqNo").text() + ", " + currentRow.find("#jobId").text() + "-" + currentRow.find("#spnSeqNo").text();
        updateSeq(values);
    }
}

$(document).ready(function() {
    var postbackElement;
    Sys.WebForms.PageRequestManager.getInstance().add_beginRequest(beginRequest);
    Sys.WebForms.PageRequestManager.getInstance().add_pageLoaded(pageLoaded);
    Sys.WebForms.PageRequestManager.getInstance().add_pageLoading(onPageLoading);
    Sys.WebForms.PageRequestManager.getInstance().add_endRequest(endRequest);
    setSequenceButtons();
});

function setSequenceButtons() {
    var totalRows = $(".gvwSilver").find("tr").length - 2;
    $(".gvwSilver").has("#spnSeqDown").find("#spnSeqDown").attr("class", "seqDownActive").attr("title", "Move Down");
    $(".gvwSilver").find("tr:eq(" + totalRows + ")").find("#spnSeqDown").attr("class", "seqDownInActive");
    $(".gvwSilver").has("#spnSeqUp").find("#spnSeqUp").attr("class", "seqUpActive").attr("title", "Move Up");
    $(".gvwSilver").find("tr:eq(1)").find("#spnSeqUp").attr("class", "seqUpInActive").attr("title", "");
}

function updateSeq(values) {
    $.post("CallBacks/JobHandler.aspx", { values: values}, function(response) {        
    });
}

