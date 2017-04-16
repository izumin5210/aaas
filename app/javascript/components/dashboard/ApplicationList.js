/* @flow */
import { PureComponent } from 'react'

import ApplicationItem from './ApplicationItem'

import type { Map } from 'immutable'

import type Application from '../../entities/Application'

type Props = {
  applications: ApplicationsState,
}

export default class ApplicationList extends PureComponent<void, Props, void> {

  renderItems() {
    return this.props.applications
      .map(app => (
        <ApplicationItem
          key={app.id}
          application={app}
        />
      ))
      .toArray()
  }

  render() {
    return (
      <ul className="Dashboard__apps">
        { this.renderItems() }
      </ul>
    )
  }
}
