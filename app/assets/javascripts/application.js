// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs

//= require bootstrap
//= require jquery.flot
//= require jquery.flot.resize
//= require jquery.flot.time
//= require jquery.flot.selection
//= require jquery.flot.tooltip.min
//= require_tree .

//Multistep form for Assessments
$(document).ready(function(){
    $('.subjective-feedback').formToWizard({ submitButton: 'createAssessment' })
});

//$(document).on('page:load', draw_chart());

$(document).ready(function draw_chart() {

    console.log("draw_chart function executed");
        var data = [];

        $('.chart_values_second_level').each(function(i, obj) {
            var secondary_data = $(this).data('values');
            var secondary_label = $(this).data('label');
            data.push({color: '#FFFFFF', label: secondary_label, data: secondary_data});
        });

         var main_data = $('#chart_values_main').data('values')
           var label = $('#chart_values_main').data('label')
   		data.push({color: '#0000FF', label: label, data: main_data});

        if (! data) {
            console.log("No data div to display found");
            return;
        };


		// helper for returning the weekends in a period

		function weekendAreas(axes) {

			var markings = [],
				d = new Date(axes.xaxis.min);

			// go to the first Saturday

			d.setUTCDate(d.getUTCDate() - ((d.getUTCDay() + 1) % 7))
			d.setUTCSeconds(0);
			d.setUTCMinutes(0);
			d.setUTCHours(0);

			var i = d.getTime();

			// when we don't set yaxis, the rectangle automatically
			// extends to infinity upwards and downwards

			do {
				markings.push({ xaxis: { from: i, to: i + 2 * 24 * 60 * 60 * 1000 } });
				i += 7 * 24 * 60 * 60 * 1000;
			} while (i < axes.xaxis.max);

			return markings;
		}

		var options = {
            series: {
                points: { show: true },
                lines: { show: true }
            },
			xaxis: {
				mode: "time",
				tickLength: 5
			},
            yaxis: {
            	min: 0,
                max: 1.0,
            	autoscaleMargin: 0.1
            			},
			selection: {
				mode: "x"
			},
			grid: {
                hoverable: true,
				markings: weekendAreas
			},
            legend: {
                show: false
            },
            tooltip: true,
            tooltipOpts: {
                content: "%s: %y.5"
            }
		};

		$.plot("#chart", data, options);

//		var overview = $.plot("#overview", data, {
//			series: {
//				lines: {
//					show: true,
//					lineWidth: 1
//				},
//				shadowSize: 0
//			},
//			xaxis: {
//				ticks: [],
//				mode: "time"
//			},
//			yaxis: {
////				ticks: [],
//				min: 0,
//				autoscaleMargin: 0.1
//			},
//			selection: {
//				mode: "x"
//			}
//		});
//
////		now connect the two
//
//		$("#chart").bind("plotselected", function (event, ranges) {
//
//			// do the zooming
//
//			plot = $.plot("#chart", data, $.extend(true, {}, options, {
//				xaxis: {
//					min: ranges.xaxis.from,
//					max: ranges.xaxis.to
//				}
//			}));
//
//			// don't fire event on the overview to prevent eternal loop
//
//			overview.setSelection(ranges, true);
//		});
//
//		$("#overview").bind("plotselected", function (event, ranges) {
//			plot.setSelection(ranges);
//		});

		// Add the Flot version string to the footer

//		$("#footer").prepend("Flot " + $.plot.version + " &ndash; ");
	});
