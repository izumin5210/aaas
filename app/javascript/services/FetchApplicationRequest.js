/* @flow */
import { List } from 'immutable'

import * as Api from './api/applications'
import Application from '../entities/Application'

type Params = {
  token: string,
  client: Api,
}

export default class FetchApplicationRequest {
  static async execute(params: Params): Promise<FetchApplicationRequest> {
    const req = new FetchApplicationRequest(params)
    await req.execute()
    return req
  }

  constructor({ token, client = Api }: Params) {
    this.token = token
    this.client = client
  }

  token: string
  client: Api
  applications: List<Application>

  async execute(): Promise<void> {
    const { response, error } = await this.client.getApps(this.token)
    if (response && response.data) {
      this.applications = List(response.data.map(app => new Application(app)))
    }
  }
}
