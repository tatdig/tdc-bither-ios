//
//  SendUtil.m
//  bither-ios
//
//  Created by 韩珍 on 2020/1/14.
//  Copyright © 2020 Bither. All rights reserved.
//

#import "SendUtil.h"
#import "NetworkUtil.h"
#import "BTPeerManager.h"

@implementation SendUtil

+ (NSString *)isCanSend:(BOOL)isSyncComplete {
    BOOL isNoNetwork = ![NetworkUtil isEnableWIFI] && ![NetworkUtil isEnable3G];
    if (isNoNetwork) {
        return NSLocalizedString(@"tip_network_error", nil);
    }
    if (!isSyncComplete) {
        return NSLocalizedString(@"no_sync_complete", nil);
    }
    BTPeerManager *peerManager = [BTPeerManager instance];
    if (peerManager.connectedPeers.count == 0) {
        return NSLocalizedString(@"tip_no_peers_connected", nil);
    }
    for (BTPeer *peer in [NSSet setWithSet:peerManager.connectedPeers]) {
        if (peerManager.lastBlockHeight < peer.displayLastBlock) {
            return [NSString stringWithFormat:NSLocalizedString(@"tip_sync_block_height", nil), @(peer.displayLastBlock - peerManager.lastBlockHeight)];
        }
        break;
    }
    return NULL;
}

@end