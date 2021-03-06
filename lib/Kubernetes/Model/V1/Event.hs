-- Copyright (c) 2016-present, SoundCloud Ltd.
-- All rights reserved.
--
-- This source code is distributed under the terms of a MIT license,
-- found in the LICENSE file.

{-# LANGUAGE DeriveGeneric              #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE TemplateHaskell            #-}

module Kubernetes.Model.V1.Event
    ( Event (..)
    , kind
    , apiVersion
    , metadata
    , involvedObject
    , reason
    , message
    , source
    , firstTimestamp
    , lastTimestamp
    , count
    , type_
    , mkEvent
    ) where

import           Control.Lens.TH                     (makeLenses)
import           Data.Aeson.TH                       (defaultOptions,
                                                      deriveJSON,
                                                      fieldLabelModifier)
import           Data.Text                           (Text)
import           GHC.Generics                        (Generic)
import           Kubernetes.Model.V1.EventSource     (EventSource)
import           Kubernetes.Model.V1.ObjectMeta      (ObjectMeta)
import           Kubernetes.Model.V1.ObjectReference (ObjectReference)
import           Prelude                             hiding (drop, error, max,
                                                      min)
import qualified Prelude                             as P
import           Test.QuickCheck                     (Arbitrary, arbitrary)
import           Test.QuickCheck.Instances           ()

-- | Event is a report of an event somewhere in the cluster.
data Event = Event
    { _kind           :: !(Maybe Text)
    , _apiVersion     :: !(Maybe Text)
    , _metadata       :: !(ObjectMeta)
    , _involvedObject :: !(ObjectReference)
    , _reason         :: !(Maybe Text)
    , _message        :: !(Maybe Text)
    , _source         :: !(Maybe EventSource)
    , _firstTimestamp :: !(Maybe Text)
    , _lastTimestamp  :: !(Maybe Text)
    , _count          :: !(Maybe Integer)
    , _type_          :: !(Maybe Text)
    } deriving (Show, Eq, Generic)

makeLenses ''Event

$(deriveJSON defaultOptions{fieldLabelModifier = (\n -> if n == "_type_" then "type" else P.drop 1 n)} ''Event)

instance Arbitrary Event where
    arbitrary = Event <$> arbitrary <*> arbitrary <*> arbitrary <*> arbitrary <*> arbitrary <*> arbitrary <*> arbitrary <*> arbitrary <*> arbitrary <*> arbitrary <*> arbitrary

-- | Use this method to build a Event
mkEvent :: ObjectMeta -> ObjectReference -> Event
mkEvent xmetadatax xinvolvedObjectx = Event Nothing Nothing xmetadatax xinvolvedObjectx Nothing Nothing Nothing Nothing Nothing Nothing Nothing
