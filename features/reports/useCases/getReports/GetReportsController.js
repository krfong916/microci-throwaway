export default class GetReportsController {
  constructor() {}
  execute(request, response, next) {
    const reports = [{ description: 'test-report' }];
    response.send(reports);
  }
}
