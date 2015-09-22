module Paths_my_project (
    version,
    getBinDir, getLibDir, getDataDir, getLibexecDir,
    getDataFileName, getSysconfDir
  ) where

import qualified Control.Exception as Exception
import Data.Version (Version(..))
import System.Environment (getEnv)
import Prelude

catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
catchIO = Exception.catch

version :: Version
version = Version [0,1,0,0] []
bindir, libdir, datadir, libexecdir, sysconfdir :: FilePath

bindir     = "/Users/TimerPro/GitHub/hspice/my-project/.stack-work/install/x86_64-osx/lts-3.6/7.10.2/bin"
libdir     = "/Users/TimerPro/GitHub/hspice/my-project/.stack-work/install/x86_64-osx/lts-3.6/7.10.2/lib/x86_64-osx-ghc-7.10.2/my-project-0.1.0.0-6TwHvH05IEZ1m5dw4W9buB"
datadir    = "/Users/TimerPro/GitHub/hspice/my-project/.stack-work/install/x86_64-osx/lts-3.6/7.10.2/share/x86_64-osx-ghc-7.10.2/my-project-0.1.0.0"
libexecdir = "/Users/TimerPro/GitHub/hspice/my-project/.stack-work/install/x86_64-osx/lts-3.6/7.10.2/libexec"
sysconfdir = "/Users/TimerPro/GitHub/hspice/my-project/.stack-work/install/x86_64-osx/lts-3.6/7.10.2/etc"

getBinDir, getLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "my_project_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "my_project_libdir") (\_ -> return libdir)
getDataDir = catchIO (getEnv "my_project_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "my_project_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "my_project_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "/" ++ name)
