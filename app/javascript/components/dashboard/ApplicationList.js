/* @flow */
import { PureComponent } from 'react'

import ApplicationItem from './ApplicationItem'

type Props = {
  applications: ApplicationsState,
}

export default class ApplicationList extends PureComponent<void, Props, void> {
  // for lint
  props: Props

  renderItems () {
    return this.props.applications
      .map(app => (
        <ApplicationItem
          key={app.id}
          application={app}
        />
      ))
      .toArray()
  }

  render () {
    return (
      <ul className='Dashboard__apps'>
        { this.renderItems() }
      </ul>
    )
  }
}
