import Component from "@glimmer/component";
import { service } from "@ember/service";
import icon from "discourse/helpers/d-icon";
import { convertIconClass } from "discourse/lib/icon-library";

export default class TrustLevelAvatarFlair extends Component {
  @service site;

  get user() {
    return this.args.model;
  }

  get trustLevel() {
    return Number(this.user?.trust_level ?? 0);
  }

  get isTl0() {
    return this.trustLevel === 0;
  }

  get isTl1() {
    return this.trustLevel === 1;
  }

  get isTl2() {
    return this.trustLevel === 2;
  }

  get isTl3() {
    return this.trustLevel === 3;
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

    return values[this.trustLevel]?.trim?.() || "";
  }

  get isImage() {
    return /^https?:\/\//i.test(this.configuredFlair);
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

    if (!value || this.isImage || this.trustLevelIcon) {
      return null;
    }

    return value;
  }

  get useMechaShield() {
    return settings.badge_style === "metal-shield" && !this.isImage;
  }

  get flairClass() {
    const classes = [
      `tl-${this.trustLevel}`,
      "tl-flair",
      `tl-flair-${this.user?.username}`,
    ];

    if (this.useMechaShield) {
      classes.push("tl-flair--mecha-shield");
    } else if (this.trustLevelEmoji) {
      classes.push("tl-flair--bare-emoji");
    }

    if (this.isImage) {
      classes.push("tl-flair--image");
    }

    return classes.join(" ");
  }

  get trustLevelName() {
    return this.site.trustLevels[this.trustLevel]?.name;
  }

  <template>
    {{#unless this.excludableNonhuman}}
      {{#if this.configuredFlair}}
        <div class="tl-avatar-flair">
          <div title={{this.trustLevelName}} class={{this.flairClass}}>
            {{#if this.useMechaShield}}
              <svg class="tl-mecha-badge" viewBox="0 0 72 80" aria-hidden="true">
                <g class="tl-mecha-badge__body">
                  <path
                    class="tl-mecha-badge__outer-shadow"
                    d="M9 7 63 7 69 13 67 50 58 66 36 78 14 66 5 50 3 13Z"
                  />
                  <path
                    class="tl-mecha-badge__outer"
                    d="M10 5 62 5 68 12 66 49 57 64 36 75 15 64 6 49 4 12Z"
                  />
                  <path
                    class="tl-mecha-badge__outer-highlight"
                    d="M11 7 61 7 65 12 63 16 58 12 14 12 9 16 7 12Z"
                  />
                  <path
                    class="tl-mecha-badge__mid"
                    d="M13 10 59 10 63 15 61 47 53 60 36 69 19 60 11 47 9 15Z"
                  />
                  <path
                    class="tl-mecha-badge__gasket"
                    d="M16 14 56 14 59 18 57 45 50 56 36 64 22 56 15 45 13 18Z"
                  />
                  <path
                    class="tl-mecha-badge__panel"
                    d="M18 17 54 17 56 20 54 43 48 53 36 60 24 53 18 43 16 20Z"
                  />
                  <path
                    class="tl-mecha-badge__panel-highlight"
                    d="M18 18 54 18 55 21 52 24 20 24 17 21Z"
                  />
                  <path
                    class="tl-mecha-badge__panel-left"
                    d="M17 21 22 25 24 52 18 43Z"
                  />
                  <path
                    class="tl-mecha-badge__panel-right"
                    d="M55 21 50 25 48 52 54 43Z"
                  />
                  <path
                    class="tl-mecha-badge__lower-shadow"
                    d="M24 53 36 60 48 53 50 56 36 64 22 56Z"
                  />
                  <path class="tl-mecha-badge__edge-light" d="M10 12 13 15 15 45 22 57" />
                  <path class="tl-mecha-badge__edge-dark" d="M62 12 59 15 57 45 50 57" />
                  <circle class="tl-mecha-badge__rivet" cx="12.5" cy="17" r="1.35" />
                  <circle class="tl-mecha-badge__rivet" cx="59.5" cy="17" r="1.35" />

                  <g class="tl-badge-icon">
                    {{#if this.isTl0}}
                      <path d="M36 51V31" />
                      <path d="M35 39C27 39 23 34 23 27c8 0 13 4 13 11" />
                      <path d="M37 34c1-7 6-11 13-11 0 8-5 13-13 13" />
                      <path d="M27 53h18" />
                    {{else if this.isTl1}}
                      <g class="tl-swords">
                        <path class="tl-sword-blade" d="M18 19 23 20 43 45 39 49 19 24Z" />
                        <path class="tl-sword-ridge" d="M21 22 41 46" />
                        <path class="tl-sword-guard" d="M35 45 43 37" />
                        <path class="tl-sword-grip" d="M41 47 47 53" />
                        <circle class="tl-sword-pommel" cx="48.5" cy="54.5" r="2" />

                        <path class="tl-sword-blade" d="M54 19 49 20 29 45 33 49 53 24Z" />
                        <path class="tl-sword-ridge" d="M51 22 31 46" />
                        <path class="tl-sword-guard" d="M37 45 29 37" />
                        <path class="tl-sword-grip" d="M31 47 25 53" />
                        <circle class="tl-sword-pommel" cx="23.5" cy="54.5" r="2" />
                      </g>
                    {{else if this.isTl2}}
                      <path d="m26 22 10 12 10-12" />
                      <circle cx="36" cy="43" r="11" />
                      <path class="tl-badge-icon__fill" d="m36 36 2.5 5 5.5.8-4 4 .9 5.6-4.9-2.6-4.9 2.6.9-5.6-4-4 5.5-.8Z" />
                    {{else if this.isTl3}}
                      <path class="tl-badge-icon__soft-fill" d="m22 31 8-10h12l8 10-14 22Z" />
                      <path d="M22 31h28M30 21l6 10 6-10M36 31v22" />
                    {{else}}
                      <path class="tl-badge-icon__soft-fill" d="m21 47-3-20 11 9 7-16 7 16 11-9-3 20Z" />
                      <path d="M22 52h28" />
                      <circle class="tl-badge-icon__fill" cx="18" cy="26" r="2" />
                      <circle class="tl-badge-icon__fill" cx="36" cy="19" r="2" />
                      <circle class="tl-badge-icon__fill" cx="54" cy="26" r="2" />
                    {{/if}}
                  </g>
                </g>
              </svg>
            {{else if this.trustLevelIcon}}
              <span class="tl-flair-symbol">{{icon this.trustLevelIcon}}</span>
            {{else if this.trustLevelEmoji}}
              <span class="tl-flair-symbol tl-flair-emoji" aria-hidden="true">{{this.trustLevelEmoji}}</span>
            {{/if}}
          </div>
        </div>
      {{/if}}
    {{/unless}}
  </template>
}
