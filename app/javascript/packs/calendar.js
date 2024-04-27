import { Calendar } from '@fullcalendar/core';
import dayGridPlugin from '@fullcalendar/daygrid';
import listPlugin from "@fullcalendar/list"; //この行を追加

document.addEventListener('DOMContentLoaded', function() {
  var calendarEl = document.getElementById('calendar');
  var calendar = new Calendar(calendarEl, {
    plugins: [dayGridPlugin, listPlugin],　//listPluginを追加
    initialView: 'dayGridMonth',
    locale: "jp",
    events: '/events.json',
    businessHours: true,
    displayEventTime: false, // 時間非表示
    //レスポンシブ処理を追加
    windowResize: function () {
        if (window.innerWidth < 991.98) {
            calendar.changeView('listMonth');
        } else {
            calendar.changeView('dayGridMonth');
        }
    },
    eventClick: (e)=>{ // イベントのクリックイベント
        window.location.href = `/posts/${e.event.id}`
	}
  });

  calendar.render();
});

// import { Calendar } from '@fullcalendar/core';
// import dayGridPlugin from '@fullcalendar/daygrid';
// import listPlugin from "@fullcalendar/list";

// document.addEventListener('DOMContentLoaded', function() {
//   var calendarEl = document.getElementById('calendar');
//   var calendar = new Calendar(calendarEl, {
//     plugins: [dayGridPlugin, listPlugin],
//     initialView: 'dayGridMonth',
//     locale: "jp", //この行を追加
//     events: '/events.json', 
//     windowResize: function () {
//         if (window.innerWidth < 991.98) {
//             calendar.changeView('listMonth');
//         } else {
//             calendar.changeView('dayGridMonth');
//         }
//     },
//   });

//   calendar.render();
// });