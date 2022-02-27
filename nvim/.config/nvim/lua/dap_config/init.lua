local dap = require("dap")

-- -- Configure Java - nvim-jdtls
-- dap.configurations.java = {
--   {
--     type = "java",
--     request = "launch",
--     name = "Launch YourClassName",

    -- -- You need to extend the classPath to list your dependencies.
    --  -- `nvim-jdtls` would automatically add the `classPaths` property if it is missing
    -- classPaths = {},

    -- -- If using multi-module projects, remove otherwise.
    -- projectName = "yourProjectName",

    -- javaExec = "/usr/bin/java",
    -- mainClass = "com.birchbox.bbopshipments.Application.java",

--     -- If using the JDK9+ module system, this needs to be extended
--     -- `nvim-jdtls` would automatically populate this property
--     modulePaths = {},
--   }
-- }

-- Configure C++/C/Rust
dap.adapters.cppdbg = {
  id = 'cppdbg',
  type = 'executable',
  command = '/Users/michaelbarnes/.vscode/extensions/ms-vscode.cpptools-1.8.4/debugAdapters/bin/OpenDebugAD7'
}

dap.configurations.cpp = {
  {
    name = "Launch file",
    type = "cppdbg",
    request = "launch",
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    cwd = '${workspaceFolder}',
    stopOnEntry = true,
    setupCommands = {
        {
           text = "-enable-pretty-printing",
           description = "enable pretty printing",
           ignoreFailures = false,
        },
    },
  },
  {
    name = 'Attach to gdbserver :1234',
    type = 'cppdbg',
    request = 'launch',
    MIMode = 'gdb',
    miDebuggerServerAddress = 'localhost:1234',
    miDebuggerPath = '/usr/local/bin/gdb',
    cwd = '${workspaceFolder}',
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
  },
}

-- If you want to use this for rust and c, add something like this:
dap.configurations.c = dap.configurations.cpp
dap.configurations.rust = dap.configurations.cpp

-- Configure Python
dap.adapters.python = {
  type = 'executable';
  command = '/Users/michaelbarnes/src/debugpy/venv/bin/python';
  args = { '-m', 'debugpy.adapter' };
}

dap.configurations.python = {
  {
    type = 'python';
    request = 'launch';
    name = "Launch file";

    -- Options below are for debugpy, see https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for supported options

    program = "${file}"; -- This configuration will launch the current file if used.
    pythonPath = function()
      -- debugpy supports launching an application with a different interpreter then the one used to launch debugpy itself.
      -- The code below looks for a `venv` or `.venv` folder in the current directly and uses the python within.
      -- You could adapt this - to for example use the `VIRTUAL_ENV` environment variable.
      local cwd = vim.fn.getcwd()
      if vim.fn.executable(cwd .. '/venv/bin/python') == 1 then
        return cwd .. '/venv/bin/python'
      elseif vim.fn.executable(cwd .. '/.venv/bin/python') == 1 then
        return cwd .. '/.venv/bin/python'
      else
        return '/usr/bin/python'
      end
    end;
  },
}
