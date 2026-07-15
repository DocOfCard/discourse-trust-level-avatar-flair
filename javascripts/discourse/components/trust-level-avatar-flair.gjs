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
              <svg class="tl-mecha-badge" viewBox="0 0 64 72" aria-hidden="true">
                <defs>
                  <linearGradient id="tl-metal-{{this.trustLevel}}" x1="0" y1="0" x2="1" y2="1">
                    <stop offset="0" stop-color="#f4f6f7" />
                    <stop offset="0.16" stop-color="#7b8188" />
                    <stop offset="0.32" stop-color="#d9dde0" />
                    <stop offset="0.55" stop-color="#43484e" />
                    <stop offset="0.76" stop-color="#aeb4b9" />
                    <stop offset="1" stop-color="#22262b" />
                  </linearGradient>
                  <linearGradient id="tl-panel-{{this.trustLevel}}" x1="0" y1="0" x2="0" y2="1">
                    <stop offset="0" stop-color="var(--tl-accent-light)" />
                    <stop offset="0.36" stop-color="var(--tl-accent)" />
                    <stop offset="1" stop-color="var(--tl-accent-dark)" />
                  </linearGradient>
                  <filter id="tl-shadow-{{this.trustLevel}}" x="-35%" y="-30%" width="170%" height="180%">
                    <feDropShadow dx="0" dy="2" stdDeviation="1.6" flood-color="#000" flood-opacity="0.72" />
                  </filter>
                </defs>

                <g filter="url(#tl-shadow-{{this.trustLevel}})">
                  <!-- angular outer armor -->
                  <path class="tl-badge-outer" d="M32 2 58 10 61 43 52 59 32 70 12 59 3 43 6 10Z" fill="url(#tl-metal-{{this.trustLevel}})" stroke="#161a1f" stroke-width="2" />
                  <!-- black gasket -->
                  <path d="M32 8 52 14 55 41 47 54 32 63 17 54 9 41 12 14Z" fill="#11161b" stroke="#05080a" stroke-width="1.5" />
                  <!-- colored armor plate -->
                  <path d="M32 11 49 16 52 39 44 50 32 58 20 50 12 39 15 16Z" fill="url(#tl-panel-{{this.trustLevel}})" stroke="rgba(255,255,255,.42)" stroke-width="1.2" />
                  <!-- aggressive panel facets -->
                  <path d="M15 16 32 11 24 31 12 39Z" fill="rgba(255,255,255,.14)" />
                  <path d="M49 16 32 11 40 31 52 39Z" fill="rgba(0,0,0,.22)" />
                  <path d="M12 39 24 31 32 58 20 50Z" fill="rgba(0,0,0,.18)" />
                  <path d="M52 39 40 31 32 58 44 50Z" fill="rgba(255,255,255,.07)" />
                  <!-- top armor ridge -->
                  <path d="M11 12 32 5 53 12 49 17 32 12 15 17Z" fill="rgba(255,255,255,.28)" />
                  <!-- rivets -->
                  <circle cx="11" cy="18" r="1.7" fill="#d7dadd" stroke="#333940" stroke-width=".8" />
                  <circle cx="53" cy="18" r="1.7" fill="#d7dadd" stroke="#333940" stroke-width=".8" />
                  <circle cx="16" cy="50" r="1.5" fill="#9da3a9" stroke="#272c31" stroke-width=".8" />
                  <circle cx="48" cy="50" r="1.5" fill="#9da3a9" stroke="#272c31" stroke-width=".8" />

                  <g class="tl-badge-icon" fill="none" stroke="#f7f8f8" stroke-width="4" stroke-linecap="round" stroke-linejoin="round">
                    {{#if (eq this.trustLevel 0)}}
                      <!-- sprout -->
                      <path d="M32 48V30" />
                      <path d="M31 35C22 34 18 29 18 22c8-1 14 3 15 10" />
                      <path d="M33 30c2-7 7-10 14-9 0 7-5 12-14 12" />
                      <path d="M24 49h16" />
                    {{else if (eq this.trustLevel 1)}}
                      <!-- crossed swords -->
                      <path d="M20 20 44 48" />
                      <path d="m18 18 9 3-6 6Z" fill="#f7f8f8" stroke="none" />
                      <path d="m39 44 7 7" />
                      <path d="M44 20 20 48" />
                      <path d="m46 18-9 3 6 6Z" fill="#f7f8f8" stroke="none" />
                      <path d="m25 44-7 7" />
                      <path d="M35 43h10M19 43h10" stroke-width="3" />
                    {{else if (eq this.trustLevel 2)}}
                      <!-- medal -->
                      <path d="m24 19 8 11 8-11" />
                      <circle cx="32" cy="40" r="11" />
                      <path d="m32 33 2.4 4.7 5.3.8-3.8 3.8.9 5.4-4.8-2.5-4.8 2.5.9-5.4-3.8-3.8 5.3-.8Z" fill="#f7f8f8" stroke="none" />
                    {{else if (eq this.trustLevel 3)}}
                      <!-- faceted gem -->
                      <path d="m19 28 7-9h12l7 9-13 21Z" fill="rgba(255,255,255,.16)" />
                      <path d="M19 28h26M26 19l6 9 6-9M32 28v21" stroke-width="2.7" />
                    {{else}}
                      <!-- crown -->
                      <path d="m18 43-3-18 10 8 7-14 7 14 10-8-3 18Z" fill="rgba(255,255,255,.14)" />
                      <path d="M19 48h26" />
                      <circle cx="15" cy="24" r="2" fill="#f7f8f8" stroke="none" />
                      <circle cx="32" cy="18" r="2" fill="#f7f8f8" stroke="none" />
                      <circle cx="49" cy="24" r="2" fill="#f7f8f8" stroke="none" />
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
