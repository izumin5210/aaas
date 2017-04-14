/* @flow */
import { PureComponent } from 'react'

import ApplicationMetaValues from './ApplicationMetaValues'

import type { Map } from 'immutable'

import type Application from '../../entities/Application'

type Props = {
  application: Application,
}

export default class ApplicationMetas extends PureComponent<void, Props, void> {

  static renderItem(key: string, values: Array<string>) {
    return [
      <dt className="key" key={`key-${key}`}>
        { key }
      </dt>,
      <dd className="value" key={`value-${key}`}>
        <ApplicationMetaValues
          {...{ values }}
        />
      </dd>
    ];
  }

  renderItems() {
    const { application } = this.props
    return [
      ApplicationMetas.renderItem('scopes', application.scopes),
      ApplicationMetas.renderItem('callback urls', application.redirectUris),
    ];
  }

  render() {
    return (
      <dl className="Dashboard__appMetas">
        { this.renderItems() }
      </dl>
    );
  }
}

