-- require'dap-python'.setup('python')
-- require'dap-python'.test_runner = 'pytest'
-- local dap = require('dap')
-- local vim = vim


-- -- dap.configurations.python = dap.configurations.python or {}
-- dap.configurations.python = {}

-- -- simple python script
-- table.insert(dap.configurations.python, {
--   type = 'python',
--   request = 'launch',
--   name = 'python-script',
--   program = '${file}',
--   console = 'integratedTerminal',
-- })


-- -- flask server
-- table.insert(dap.configurations.python, {
--   type = 'python';
--   request = 'launch';
--   name = 'python-flask';
--   console = 'integratedTerminal';
--   module = 'flask';
--   -- args = {'run'};
--   args = {'run', '--port', '10469'};
--   env = {
--     FLASK_APP= "${file}";
--     FLASK_ENV= "development";
--     FLASK_DEBUG= "0"
--   }
-- })


-- -- flask server args
-- -- run --port 10469
-- table.insert(dap.configurations.python, {
--   type = 'python';
--   request = 'launch';
--   name = 'python-flask-args';
--   console = 'integratedTerminal';
--   module = 'flask';
--   args = function()
--     local args_string = vim.fn.input('Arguments: ')
--     return vim.split(args_string, " +")
--   end;
--   env = {
--     FLASK_APP= "${file}";
--     FLASK_ENV= "development";
--     FLASK_DEBUG= "0"
--   }
-- })
