/*
 * Copyright (c) 2010 J. David Beutel <software@getsu.com>
 *
 * Licensed under the MIT license: http://www.opensource.org/licenses/mit-license.php
 */
/* requires <g:javascript library="scriptaculous"/> */
var ExpandManager = {
    init: function() {
        $$('a.ExpandManager.swapToNextRow').invoke('observe', 'click', ExpandManager.swapToNextRow);
        $$('a.ExpandManager.swapToPreviousRow').invoke('observe', 'click', ExpandManager.swapToPreviousRow);
        $$('a.ExpandManager.swapToUpperPreviousRow').invoke('observe', 'click', ExpandManager.swapToUpperPreviousRow);
        $$('a.ExpandManager.swapToNextDiv').invoke('observe', 'click', ExpandManager.swapToNextDiv);
        $$('a.ExpandManager.swapToPreviousDiv').invoke('observe', 'click', ExpandManager.swapToPreviousDiv);
    },
    swapToNextRow: function(/*event*/) {
        var thisRow = this.up('tr');
        var nextRow = thisRow.next();
        var divToReveal = nextRow.down('div');
        divToReveal.hide();
        nextRow.show();
        var options = {duration:0.5};
        if (Prototype.Browser.WebKit) { // for Chrome, at least, to help keep the :hover
            var frameCount = 0;
            options.afterUpdate = function() {
                if (frameCount++ == 3) {
                    thisRow.hide();
                }
            }
        } else {
            options.beforeStart = function() {
                thisRow.hide();
            }
        }
        divToReveal.blindDown(options);
        return true; // have the browser also handle this event
    },
    swapToPreviousRow: function(/*event*/) {
        var thisRow = this.up('tr');
        var divToConceal = thisRow.down('div');
        var previousRow = thisRow.previous();
        divToConceal.blindUp( {duration:0.5,
            afterFinish:function() {
                previousRow.show();
                thisRow.hide();
            }
        });
        return true; // have the browser also handle this event
    },
    swapToUpperPreviousRow: function(/*event*/) {
        var thisRow = this.up('tr').up('tr');
        var divToConceal = thisRow.down('div');
        var previousRow = thisRow.previous();
        divToConceal.blindUp( {duration:0.5,
            afterFinish:function() {
                previousRow.show();
                thisRow.hide();
            }
        });
        return true; // have the browser also handle this event
    },
    swapToNextDiv: function(/*event*/) {
        var divToConceal = this.up('div');
        var nextDiv = divToConceal.next('div');
        divToConceal.hide();
        nextDiv.blindDown( {duration:0.5});
        return true; // have the browser also handle this event
    },
    swapToPreviousDiv: function(/*event*/) {
        var divToConceal = this.up('div').up('div'); // blindUp/Down needs double div
        var previousDiv = divToConceal.previous('div');
        divToConceal.blindUp( {duration:0.5,
            afterFinish:function() {
                previousDiv.show();
            }
        });
        return true; // have the browser also handle this event
    }
};
