import Component from "@glimmer/component";
import { service } from "@ember/service";
import icon from "discourse/helpers/d-icon";
import { convertIconClass } from "discourse/lib/icon-library";

export default class TrustLevelAvatarFlair extends Component {
  @service site;

  get user() { return this.args.model; }
  get trustLevel() { return Number(this.user?.trust_level ?? 0); }
  get excludableNonhuman() { return settings.exclude_nonhuman_users && this.user?.id < 0; }

  get configuredFlair() {
    const values = [settings.new_user_flair_icon, settings.basic_user_flair_icon, settings.member_flair_icon, settings.regular_flair_icon, settings.leader_flair_icon];
    return values[this.trustLevel]?.trim?.() || "";
  }

  get trustLevelIcon() {
    const value = this.configuredFlair;
    return settings.use_font_awesome && value.includes("fa-") ? convertIconClass(value) : null;
  }

  get useCustomSvg() { return settings.badge_style === "custom-svg"; }
  get trustLevelEmoji() { return this.trustLevelIcon ? null : this.configuredFlair; }
  get trustLevelName() { return this.site.trustLevels[this.trustLevel]?.name; }

  get flairClass() {
    return [`tl-${this.trustLevel}`, "tl-flair", `tl-flair-${this.user?.username}`, this.useCustomSvg ? "tl-flair--custom-svg" : "tl-flair--bare"].join(" ");
  }

  <template>
    {{#unless this.excludableNonhuman}}
      <div class="tl-avatar-flair">
        <div title={{this.trustLevelName}} class={{this.flairClass}}>
          {{#if this.useCustomSvg}}
            <span class="tl-custom-svg-badge" aria-hidden="true"></span>
          {{else if this.trustLevelIcon}}
            <span class="tl-flair-symbol">{{icon this.trustLevelIcon}}</span>
          {{else}}
            <span class="tl-flair-symbol tl-flair-emoji" aria-hidden="true">{{this.trustLevelEmoji}}</span>
          {{/if}}
        </div>
      </div>
    {{/unless}}
  </template>
}
