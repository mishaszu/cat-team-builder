module type Sandbox = {
  type model
  type msg
  let initialModel: model
  let update: (model, msg) => model
  let view: (msg => unit, model, 'a) => React.element
}

let useSandbox = (sandbox: module(Sandbox))  => {
  let module(Sandbox) = sandbox
  let (model, dispatch) = React.useReducer(Sandbox.update, Sandbox.initialModel)
  Sandbox.view(dispatch, model)
}
