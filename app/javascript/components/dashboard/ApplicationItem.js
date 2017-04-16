/* @flow */
import { PureComponent } from 'react'

import ApplicationMetas from './ApplicationMetas'

import type { Map } from 'immutable'

import type Application from '../../entities/Application'

type Props = {
  application: Application,
}

export default class ApplicationItem extends PureComponent<void, Props, void> {

  renderAppName() {
    const { application } = this.props
    return (
      <span className="Dashboard__appName">
        <a href="/" className="Dashboard__appNameLink">
          { application.name }
        </a>
      </span>
    );
  }

  render() {
    return (
      <li className="Dashboard__app">
        { this.renderAppName() }
        <ApplicationMetas
          application={this.props.application}
        />
      </li>
    )
  }
}
