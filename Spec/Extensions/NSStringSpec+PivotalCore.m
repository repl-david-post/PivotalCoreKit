#import <Cedar/SpecHelper.h>
#import <OCMock/OCMock.h>
#define HC_SHORTHAND
#import <OCHamcrest/OCHamcrest.h>

#import "NSString+PivotalCore.h"

SPEC_BEGIN(NSString_PivotalCore)

describe(@"Pivotal Core extensions to NSString", ^{
    describe(@"initWithBase64EncodedData:", ^{
        __block NSString *newString = nil;

        afterEach(^{
            [newString release];
        });

        describe(@"with 20 bytes of blank data", ^{
            beforeEach(^{
                char bytes[20];
                for (int i = 0; i < 20; ++i) {
                    bytes[i] = 0;
                }
                newString = [[NSString alloc] initWithBase64EncodedData:[NSData dataWithBytes:bytes length:20]];
            });

            it(@"should create a correctly base-64 encoded string", ^{
                assertThat(newString, equalTo(@"AAAAAAAAAAAAAAAAAAAAAAAAAAA="));
            });
        });

        describe(@"with 20 bytes of non-blank data", ^{
            beforeEach(^{
                const char bytes[20] = {'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't'};
                newString = [[NSString alloc] initWithBase64EncodedData:[NSData dataWithBytes:bytes length:20]];
            });

            it(@"should create a correctly base-64 encoded string", ^{
                assertThat(newString, equalTo(@"YWJjZGVmZ2hpamtsbW5vcHFyc3Q="));
            });
        });

        describe(@"with 0 bytes of data", ^{
            beforeEach(^{
                newString = [[NSString alloc] initWithBase64EncodedData:[NSData data]];
            });

            it(@"should create a correctly base-64 encoded string", ^{
                assertThat(newString, equalTo(@""));
            });
        });

        describe(@"with 1 byte of data", ^{
            beforeEach(^{
                const char bytes[1] = {'A'};
                newString = [[NSString alloc] initWithBase64EncodedData:[NSData dataWithBytes:bytes length:1]];
            });

            it(@"should create a correctly base-64 encoded string", ^{
                assertThat(newString, equalTo(@"QQ=="));
            });
        });

        describe(@"with 2 bytes of data", ^{
            beforeEach(^{
                const char bytes[2] = {'A', 'B'};
                newString = [[NSString alloc] initWithBase64EncodedData:[NSData dataWithBytes:bytes length:2]];
            });

            it(@"should create a correctly base-64 encoded string", ^{
                assertThat(newString, equalTo(@"QUI="));
            });
        });

        describe(@"with 3 bytes of data", ^{
            beforeEach(^{
                const char bytes[3] = {'A', 'B', 'C'};
                newString = [[NSString alloc] initWithBase64EncodedData:[NSData dataWithBytes:bytes length:3]];
            });

            it(@"should create a correctly base-64 encoded string", ^{
                assertThat(newString, equalTo(@"QUJD"));
            });
        });
    });

    static const NSString *INVALID_URL_CHARACTERS[] = {
        @" ", @"\"", @"#", @"$", @"%", @"&", @"+", @",",
        @"/", @":", @";", @"<", @"=", @">", @"?", @"@",
        @"[", @"\\", @"]", @"^", @"`", @"{", @"|", @"}", @"~"
    };

    static const NSString *ESCAPED_URL_CHARACTERS[] = {
        @"%20", @"%22", @"%23", @"%24", @"%25", @"%26", @"%2B", @"%2C",
        @"%2F", @"%3A", @"%3B", @"%3C", @"%3D", @"%3E", @"%3F", @"%40",
        @"%5B", @"%5C", @"%5D", @"%5E", @"%60", @"%7B", @"%7C", @"%7D", @"%7E"
    };

    describe(@"stringByAddingPercentEscapesUsingEncoding:", ^{
        it(@"should properly escape all invalid URL characters", ^{
            size_t invalidCount = sizeof(INVALID_URL_CHARACTERS) / sizeof(NSString *);
            size_t escapedCount = sizeof(ESCAPED_URL_CHARACTERS) / sizeof(NSString *);
            assertThatInt(invalidCount, equalToInt(escapedCount));

            for (unsigned int i = 0; i < invalidCount; ++i) {
                NSString *stringWithInvalidCharacter = [NSString stringWithFormat:@"foo%@bar", INVALID_URL_CHARACTERS[i]];
                NSString *stringWithEscapedCharacter = [NSString stringWithFormat:@"foo%@bar", ESCAPED_URL_CHARACTERS[i]];
                assertThat([stringWithInvalidCharacter stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding], equalTo(stringWithEscapedCharacter));
            }
        });
    });
});

SPEC_END
