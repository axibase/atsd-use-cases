<template>
  <div class="sidebar-group" :class="{ first, collapsable }">
    <p class="sidebar-heading" :class="{ open }" @click="$emit('toggle')">
      <span>{{ item.title }}</span>
      <span class="arrow"
        v-if="collapsable"
        :class="open ? 'down' : 'right'"></span>
    </p>
    <DropdownTransition>
      <ul class="sidebar-group-items" ref="items" v-if="open || !collapsable">
        <li v-for="child in item.children">
          <SidebarLink :item="child"/>
        </li>
      </ul>
    </DropdownTransition>
  </div>
</template>

<script>
import SidebarLink from './SidebarLink.vue'
import DropdownTransition from './DropdownTransition.vue'

export default {
  name: 'SidebarGroup',
  props: ['item', 'first', 'open', 'collapsable'],
  components: { SidebarLink, DropdownTransition }
}
</script>

<style lang="stylus">
.sidebar-group
  .sidebar-group
    padding-left 0.5em
  &:not(.collapsable)
    .sidebar-heading
      cursor auto
      color inherit

.sidebar-heading
  cursor pointer
  padding 0.35rem 1rem 0.35rem 1.5rem
  margin-top 0
  margin-bottom 0
  &.open
    color inherit
  &:hover
    color #f08d49
  .arrow
    position relative
    top -0.12em
    left 0.5em
  &:hover .arrow
    border-left-color #f08d49 
  &.open .arrow
    top -0.18em
  &.open:hover .arrow    
    border-left-color transparent 
    border-top-color #f08d49 

.sidebar-group-items
  transition height .1s ease-out
  overflow hidden
</style>
