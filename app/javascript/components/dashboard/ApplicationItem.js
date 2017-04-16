/* @flow */
import { PureComponent } from 'react'

import ApplicationMetas from './ApplicationMetas'

import type Application from '../../entities/Application'

type Props = {
  application: Application,
}

export default class ApplicationItem extends PureComponent<void, Props, void> {
  // for lint
  props: Props

  renderAppName () {
    const { application } = this.props
    return (
      <span className='Dashboard__appName'>
        <a href='/' className='Dashboard__appNameLink'>
          { application.name }
        </a>
      </span>
    )
  }

  render () {
    return (
      <li className='Dashboard__app'>
        { this.renderAppName() }
        <ApplicationMetas
          application={this.props.application}
        />
      </li>
    )
  }
}
