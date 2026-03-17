import Component from "@glimmer/component";
import { inject as service } from "@ember/service";
import { action } from "@ember/object";
import DButton from "discourse/components/d-button";
import { themePrefix } from "discourse/lib/theme-prefix";

// To render the button into the DOM once the page and toolbar are ready
function ready(fn) {
  if (document.readyState !== "loading") fn();
  else document.addEventListener("DOMContentLoaded", fn);
}

export default class UpcomingEventsNewTopicButton extends Component {
  @service router;

  get showButton() {
    // Only show on upcoming-events route
    return (
      this.router.currentRouteName ===
      "discourse-post-event-upcoming-events.index"
    );
  }

  @action
  goToLink() {
    window.location.href = settings.new_event_link;
  }

  @action
  insertButton(el) {
    // Insert after "My events" button (if needed, tweak this selector to your needs)
    const toolbar = document.querySelector('.fc-allEvents-button')?.parentElement;
    if (!toolbar) return;
    if (toolbar.querySelector('.fc-newEvent-button')) return; // idempotent

    toolbar.appendChild(el);
  }

  <template>
    {{#if this.showButton}}
      <DButton
        @class="fc-newEvent-button fc-button fc-button-primary"
        @icon={{settings.new_event_icon}}
        @action={{this.goToLink}}
        @translatedLabel={{theme-i18n (themePrefix "upcoming_events.new_event")}}
        @title={{theme-i18n (themePrefix "upcoming_events.new_event_aria")}}
        {{did-insert this.insertButton}}
      />
    {{/if}}
  </template>
}
