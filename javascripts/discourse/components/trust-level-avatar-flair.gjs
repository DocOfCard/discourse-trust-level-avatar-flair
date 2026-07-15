import Component from "@glimmer/component";
import { service } from "@ember/service";
import icon from "discourse/helpers/d-icon";
import { convertIconClass } from "discourse/lib/icon-library";

export default class TrustLevelAvatarFlair extends Component {
  @service site;

  get user() {
    return this.args.model;
  }

  get excludableNonhuman() {
    return settings.exclude_nonhuman_users && this.user?.id < 0;
  }

  get configuredFlair() {
    const values = [
      settings.new_user_flair_icon,
      settings.basic_user_flair_icon,
      settings.member_flair_icon,
      settings.regular_flair_icon,
      settings.leader_flair_icon,
    ];

    return values[this.user?.trust_level]?.trim?.() || "";
  }

  get trustLevelIcon() {
    const value = this.configuredFlair;

    if (settings.use_font_awesome && value.includes("fa-")) {
      return convertIconClass(value);
    }

    return null;
  }

  get trustLevelEmoji() {
    const value = this.configuredFlair;

    if (
      !value ||
      settings.use_font_awesome ||
      /^https?:\/\//i.test(value) ||
      value.includes("fa-")
    ) {
      return null;
    }

    return value;
  }

  get trustLevelName() {
    return this.site.trustLevels[this.user?.trust_level]?.name;
  }

  <template>
    {{#unless this.excludableNonhuman}}
      {{#if this.configuredFlair}}
        <div class="tl-avatar-flair">
          <div
            title={{this.trustLevelName}}
            class="tl-{{this.user.trust_level}} tl-flair tl-flair-{{this.user.username}}"
          >
            {{#if this.trustLevelIcon}}
              {{icon this.trustLevelIcon}}
            {{else if this.trustLevelEmoji}}
              <span class="tl-flair-emoji" aria-hidden="true">{{this.trustLevelEmoji}}</span>
            {{/if}}
          </div>
        </div>
      {{/if}}
    {{/unless}}
  </template>
}
