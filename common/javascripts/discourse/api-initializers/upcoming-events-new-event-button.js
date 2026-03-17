import { apiInitializer } from "discourse/lib/api";

// Translation helpers
import { themePrefix } from "discourse/lib/theme-prefix";
import I18n from "I18n";

export default apiInitializer(() => {
  function addCustomButton() {
    const toolbar = document.querySelector('.fc-allEvents-button')?.parentElement;
    if (!toolbar) return;
    if (toolbar.querySelector('.fc-newEvent-button')) return;

    // Button
    const btn = document.createElement("button");
    btn.className = "fc-newEvent-button fc-button fc-button-primary";
    btn.title = I18n.t(themePrefix("upcoming_events.new_event_aria"));
    btn.innerHTML = `
      <span class="icon" style="margin-right: 0.4em;">
        <svg class="fa d-icon d-icon-${settings.new_event_icon} svg-icon" width="1em" height="1em" aria-hidden="true">
          <use href="#${settings.new_event_icon}"></use>
        </svg>
      </span>
      ${I18n.t(themePrefix("upcoming_events.new_event"))}
    `;
    btn.onclick = function () {
      window.location.href = settings.new_event_link;
    };

    // Insert after ".fc-mineEvents-button"
    toolbar.querySelector('.fc-mineEvents-button')?.after(btn);
  }

  // React to route changes
  api.onPageChange(() => {
    const route = api.container.lookup('service:router');
    if (route.currentRouteName === "discourse-post-event-upcoming-events.index") {
      setTimeout(addCustomButton, 100); // Allow calendar toolbar to be rendered
    }
  });
});
