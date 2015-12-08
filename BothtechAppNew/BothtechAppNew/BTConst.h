#ifdef DEBUG
#define BTLog(...) NSLog(__VA_ARGS__)
#else
#define BTLog(...)
#endif

#define BTColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define BTGlobalBg BTColor(230, 230, 230)