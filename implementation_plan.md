# 🚀 My Bad Customer — Production-Ready Implementation Plan

> **Project:** My Bad Customer
> **Goal:** A platform where verified business owners can report and check customers who caused business problems
> **Tech Stack:** Flutter + NestJS + PostgreSQL + Prisma + Cloudinary + FCM + React/Next.js
> **Strategy:** Phase-wise development → Backend first → Frontend second → Integration → Test → Next Phase

---

## 📋 Phase Overview

| Phase | Name | Focus | Dependencies |
|-------|------|-------|-------------|
| **0** | Environment Setup | Install all tools, verify everything works | None |
| **1** | Project Foundation | Folder structure, base config, theme, error handling patterns | Phase 0 |
| **2** | Authentication System | Register, Login, JWT, Refresh Token, Guards | Phase 1 |
| **3** | Business Profile & Verification | Business registration, proof upload, admin verification | Phase 2 |
| **4** | Customer Management & Search | Customer records, search, pagination, results display | Phase 2 |
| **5** | Customer Reporting & Evidence | Report submission, evidence upload, report tracking | Phase 3 + 4 |
| **6** | Admin Panel (Web) | Dashboard, business mgmt, report review, evidence view | Phase 5 |
| **7** | Push Notifications (FCM) | Real-time notifications for all status changes | Phase 6 |
| **8** | Polish, Security & Deployment | Error handling, testing, security hardening, production build | Phase 7 |

---

# ═══════════════════════════════════════════
# PHASE 0: ENVIRONMENT SETUP
# ═══════════════════════════════════════════

**Goal:** Sab development tools install karke verify karna ki Flutter app emulator pe chalta hai aur NestJS server localhost pe response deta hai.

> [!IMPORTANT]
> Ye phase sabse critical hai. Agar setup sahi nahi hua to aage kuch nahi hoga. Patience se karna hai — mobile development ka setup web se zyada complex hota hai.

### 🎓 Learning:
> **Flutter** = Google ka UI framework. Ek Dart codebase se Android + iOS app banta hai. React jaisa component-based hai.
> **Dart** = Flutter ki language. JavaScript jaisi syntax hai — classes, async/await, types sab same concept.
> **Android Studio** = Android development ke tools deta hai — emulator, SDK, build tools. Flutter ko ye chahiye internally.

---

### Step 0.1: Flutter SDK Install
- [x] Flutter SDK download karo (stable channel) — Flutter 3.24.3 downloaded ✅
- [x] Extract karo aur PATH mein add karo (`~/.zshrc`) — `/home/yogesh/development/flutter` ✅
- [x] Terminal restart karo aur verify karo: `flutter --version` — Flutter 3.24.3 ✅
- [x] Dart bhi saath install ho jayega — verify: `dart --version` — Dart 3.5.3 ✅

### Step 0.2: Android Studio Install
- [x] Android Studio download karo — https://developer.android.com/studio ✅
- [x] Extract/install karo ✅
- [x] Android Studio open karo → SDK Manager → Install: ✅
  - Android SDK (latest stable)
  - Android SDK Command-line Tools
  - Android SDK Build-Tools
  - Android SDK Platform-Tools
- [x] Flutter plugin install karo Android Studio mein (Settings → Plugins → Flutter) ✅
- [x] Dart plugin bhi install hoga automatically ✅

### Step 0.3: Android Emulator Setup
- [x] Android Studio → Device Manager → Create Virtual Device ✅
- [x] Select: Pixel 6 (ya koi bhi medium size) ✅
- [x] Select System Image: API 34 (Android 14) ya latest ✅
- [x] Emulator start karo → verify karta hai ki chalta hai ✅
- [ ] **Alternative:** Physical Android phone USB se connect karo
  - Phone mein Developer Options enable karo
  - USB Debugging ON karo
  - `flutter devices` se verify karo phone dikhta hai

### Step 0.4: Flutter Doctor — Full Green Check
- [ ] Run: `flutter doctor`
- [ ] Har item green hona chahiye:
  - ✅ Flutter (Channel stable)
  - ✅ Android toolchain
  - ✅ Android Studio
  - ✅ Connected device (emulator ya physical)
- [ ] Agar koi issue aaye → `flutter doctor -v` se detail dekho aur fix karo
- [ ] Accept Android licenses: `flutter doctor --android-licenses`

### Step 0.5: NestJS CLI Install
- [x] Install: `npm install -g @nestjs/cli` ✅
- [x] Verify: `nest --version` ✅

### Step 0.6: PostgreSQL Database Create
- [ ] PostgreSQL service running verify karo: `sudo systemctl status postgresql`
- [ ] Database create karo:
  ```sql
  sudo -u postgres psql
  CREATE DATABASE my_bad_customer_db;
  CREATE USER mbc_user WITH ENCRYPTED PASSWORD 'your_secure_password';
  GRANT ALL PRIVILEGES ON DATABASE my_bad_customer_db TO mbc_user;
  \q
  ```
- [ ] Connection test karo: `psql -U mbc_user -d my_bad_customer_db -h localhost`

### Step 0.7: Project Directory Structure Create
- [x] Main project directory setup: ✅
  ```
  my-bad-customer/
  ├── mobile/          ← Flutter app (Phase 0 mein create)
  ├── backend/         ← NestJS server (Phase 0 mein create)
  ├── admin-panel/     ← React/Next.js (Phase 6 mein create)
  ├── docs/            ← Documentation
  └── context.txt      ← Original context (existing)
  ```

### Step 0.8: Blank Flutter Project Create
- [x] `flutter create --org com.mybadcustomer --project-name my_bad_customer mobile` ✅
- [x] `cd mobile && flutter pub get` ✅
- [x] `flutter run` — emulator/device pe default counter app dikhni chahiye ✅
- [x] ✅ **Checkpoint:** Flutter app successfully running on device/emulator ✅

### Step 0.9: Blank NestJS Project Create
- [x] `nest new backend --package-manager npm --skip-git` ✅
- [x] `cd backend && npm run start:dev` ✅
- [x] Browser mein `http://localhost:3000` → "Hello World!" dikhna chahiye ✅
- [x] ✅ **Checkpoint:** NestJS server running on localhost:3000 ✅

### Step 0.10: Git Initialize
- [x] Root directory mein `git init` ✅
- [x] `.gitignore` create karo: ✅
  ```
  # Flutter
  mobile/.dart_tool/
  mobile/.flutter-plugins
  mobile/.flutter-plugins-dependencies
  mobile/build/
  mobile/.packages
  mobile/android/.gradle/
  mobile/ios/Pods/
  
  # NestJS
  backend/node_modules/
  backend/dist/
  
  # Admin Panel
  admin-panel/node_modules/
  admin-panel/.next/
  
  # Environment
  .env
  *.env.local
  
  # IDE
  .idea/
  .vscode/
  *.iml
  ```
- [x] First commit: `git add . && git commit -m "Phase 0: Initial project setup"` ✅

### ✅ Phase 0 Verification Checklist:
- [x] `flutter doctor` — all green ✅
- [x] Flutter app runs on emulator/device ✅
- [x] NestJS server runs on localhost:3000 ✅
- [x] PostgreSQL database created and accessible ✅
- [x] Git repository initialized ✅
- [x] Both projects in correct directory structure ✅

---

# ═══════════════════════════════════════════
# PHASE 1: PROJECT FOUNDATION
# ═══════════════════════════════════════════

**Goal:** Dono projects (Flutter + NestJS) ka base architecture setup karna — folder structure, configurations, theming, error handling patterns, environment variables, Prisma setup. Ye sab baad mein har phase use karega.

> [!NOTE]
> Ye phase mein koi feature nahi banega. Sirf foundation banega — jaise building ki neev. Agar ye sahi hai to baaki sab smooth chalega.

### 🎓 Learning:
> **NestJS Module System:** NestJS mein har feature ek Module hai (like a package). Module ke andar Controller (routes handle), Service (business logic), DTO (data validation) hote hain. Express mein ye sab ek file mein hota tha — NestJS mein organized hai.
>
> **Flutter State Management:** React mein useState/Redux hota hai — Flutter mein Provider/Riverpod hota hai. Hum Provider use karenge (simple, official, sufficient).
>
> **Prisma:** Tum ek `.prisma` file mein schema likhte ho (tables + columns define). Fir `prisma migrate` chalate ho — tables automatically ban jaati hain. Queries bhi type-safe hoti hain.

---

## 1A — Backend Foundation (NestJS)

### Step 1.1: Install Core Dependencies
- [x] Navigate to backend: `cd backend` ✅
- [x] Install production dependencies: ✅
  ```bash
  npm install @nestjs/config @nestjs/passport @nestjs/jwt passport passport-jwt
  npm install @prisma/client bcryptjs class-validator class-transformer
  npm install helmet compression express-rate-limit
  npm install cloudinary multer @nestjs/platform-express
  npm install firebase-admin
  ```
- [x] Install dev dependencies: ✅
  ```bash
  npm install -D prisma @types/passport-jwt @types/bcryptjs @types/multer
  ```

### Step 1.2: Environment Variables Setup
- [x] Create `backend/.env`: ✅
  ```env
  # App
  NODE_ENV=development
  PORT=3000
  API_PREFIX=api/v1
  
  # Database
  DATABASE_URL="postgresql://mbc_user:your_secure_password@localhost:5432/my_bad_customer_db?schema=public"
  
  # JWT
  JWT_ACCESS_SECRET=your_access_secret_key_min_32_chars
  JWT_REFRESH_SECRET=your_refresh_secret_key_min_32_chars
  JWT_ACCESS_EXPIRATION=15m
  JWT_REFRESH_EXPIRATION=7d
  
  # Cloudinary
  CLOUDINARY_CLOUD_NAME=your_cloud_name
  CLOUDINARY_API_KEY=your_api_key
  CLOUDINARY_API_SECRET=your_api_secret
  
  # Firebase
  FIREBASE_PROJECT_ID=your_project_id
  FIREBASE_PRIVATE_KEY=your_private_key
  FIREBASE_CLIENT_EMAIL=your_client_email
  ```
- [ ] Create `backend/.env.example` (same file without actual values — for git)
- [ ] Add `.env` to `.gitignore`

### Step 1.3: Prisma Initialize
- [x] Run: `npx prisma init` ✅
- [x] Ye `prisma/schema.prisma` file banayega ✅
- [x] `schema.prisma` mein datasource verify karo: ✅
  ```prisma
  datasource db {
    provider = "postgresql"
    url      = env("DATABASE_URL")
  }
  
  generator client {
    provider = "prisma-client-js"
  }
  ```
- [x] Run: `npx prisma db push` (verify connection works) ✅

### Step 1.4: Prisma Service Create
- [x] Create `backend/src/prisma/prisma.module.ts` ✅
- [x] Create `backend/src/prisma/prisma.service.ts` ✅
  - OnModuleInit mein `$connect()` call
  - enableShutdownHooks for graceful shutdown
- [x] PrismaModule ko `@Global()` mark karo (har module mein use hoga) ✅

### Step 1.5: Backend Folder Structure Create
- [x] Complete folder structure: ✅
  ```
  backend/src/
  ├── main.ts                          ← App entry point
  ├── app.module.ts                    ← Root module
  │
  ├── common/                          ← Shared utilities
  │   ├── decorators/
  │   │   ├── current-user.decorator.ts   ← Get logged-in user from request
  │   │   └── roles.decorator.ts          ← @Roles(Role.ADMIN) decorator
  │   ├── dto/
  │   │   └── pagination.dto.ts           ← Reusable pagination DTO
  │   ├── filters/
  │   │   └── http-exception.filter.ts    ← Global error response format
  │   ├── guards/
  │   │   └── roles.guard.ts              ← Role-based access guard
  │   ├── interceptors/
  │   │   ├── response.interceptor.ts     ← Standard success response format
  │   │   └── logging.interceptor.ts      ← Request/Response logging
  │   ├── interfaces/
  │   │   └── api-response.interface.ts   ← Standard API response type
  │   └── utils/
  │       └── helpers.ts                  ← Utility functions
  │
  ├── prisma/                          ← Database
  │   ├── prisma.module.ts
  │   └── prisma.service.ts
  │
  ├── auth/                            ← Phase 2
  ├── users/                           ← Phase 2
  ├── business/                        ← Phase 3
  ├── customers/                       ← Phase 4
  ├── reports/                         ← Phase 5
  ├── evidence/                        ← Phase 5
  ├── notifications/                   ← Phase 7
  ├── cloudinary/                      ← Phase 3 (shared service)
  └── admin/                           ← Phase 6
  ```

### Step 1.6: Global Error Handling Setup
- [x] Create `http-exception.filter.ts`: ✅
  - Har error ka response ek consistent format mein hoga:
    ```json
    {
      "success": false,
      "statusCode": 400,
      "message": "Validation failed",
      "errors": ["email must be a valid email"],
      "timestamp": "2024-01-01T00:00:00.000Z",
      "path": "/api/v1/auth/register"
    }
    ```
- [x] Create `response.interceptor.ts`: ✅
  - Har success response ka format:
    ```json
    {
      "success": true,
      "statusCode": 200,
      "message": "Operation successful",
      "data": { ... },
      "timestamp": "2024-01-01T00:00:00.000Z"
    }
    ```

### Step 1.7: Global Pipes & Security Setup (main.ts)
- [x] `main.ts` mein configure karo: ✅
  ```typescript
  // Global validation pipe (auto-validate all DTOs)
  app.useGlobalPipes(new ValidationPipe({
    whitelist: true,          // strip unknown properties
    forbidNonWhitelisted: true, // throw error on unknown properties
    transform: true,          // auto-transform types
  }));
  
  // Security
  app.use(helmet());         // Security headers
  app.use(compression());    // Gzip compression
  
  // CORS
  app.enableCors({
    origin: ['http://localhost:3001'], // Admin panel
    credentials: true,
  });
  
  // Rate limiting
  app.use(rateLimit({
    windowMs: 15 * 60 * 1000, // 15 minutes
    max: 100,                  // 100 requests per window
  }));
  
  // API prefix
  app.setGlobalPrefix('api/v1');
  ```

### Step 1.8: Pagination DTO Create
- [x] Create reusable pagination DTO: ✅
  ```typescript
  // pagination.dto.ts
  class PaginationDto {
    @IsOptional()
    @Type(() => Number)
    @IsInt()
    @Min(1)
    page?: number = 1;
    
    @IsOptional()
    @Type(() => Number)
    @IsInt()
    @Min(1)
    @Max(50)
    limit?: number = 10;
  }
  ```
- [ ] Create pagination response helper:
  ```typescript
  {
    "data": [...],
    "meta": {
      "total": 150,
      "page": 1,
      "limit": 10,
      "totalPages": 15,
      "hasNextPage": true,
      "hasPrevPage": false
    }
  }
  ```

### Step 1.9: Logging Interceptor
- [x] Create logging interceptor jo har request log kare: ✅
  ```
  [POST] /api/v1/auth/register - 201 - 45ms
  [GET] /api/v1/customers/search?name=John - 200 - 12ms
  ```

### Step 1.10: Backend Foundation Verify
- [x] `npm run start:dev` — no errors ✅
- [x] API prefix work kare: `GET http://localhost:3000/api/v1` → response ✅
- [x] Global error filter kaam kare (wrong route → formatted error) ✅
- [x] Git commit: `git commit -m "Phase 1A: Backend foundation setup"` ✅

---

## 1B — Flutter Foundation (Mobile App)

### Step 1.11: Flutter Project Clean & Organize
- [x] Delete default counter app code from `lib/main.dart` ✅
- [x] Create complete folder structure: ✅
  ```
  mobile/lib/
  ├── main.dart                        ← App entry point
  │
  ├── config/                          ← App configuration
  │   ├── app_config.dart              ← API URL, app name, constants
  │   ├── routes.dart                  ← All route definitions
  │   └── theme/
  │       ├── app_theme.dart           ← ThemeData (colors, fonts, etc.)
  │       ├── app_colors.dart          ← Color palette
  │       ├── app_text_styles.dart     ← Text styles
  │       └── app_dimensions.dart      ← Padding, margin, radius values
  │
  ├── models/                          ← Data models (like TypeScript interfaces)
  │   ├── user_model.dart
  │   ├── business_model.dart
  │   ├── customer_model.dart
  │   ├── report_model.dart
  │   ├── evidence_model.dart
  │   └── api_response_model.dart
  │
  ├── services/                        ← API calls & external services
  │   ├── api/
  │   │   ├── api_client.dart          ← Base HTTP client (Dio) with interceptors
  │   │   ├── api_endpoints.dart       ← All API endpoint strings
  │   │   ├── api_exceptions.dart      ← Custom exception classes
  │   │   ├── auth_api.dart            ← Auth API calls
  │   │   ├── business_api.dart        ← Business API calls
  │   │   ├── customer_api.dart        ← Customer API calls
  │   │   ├── report_api.dart          ← Report API calls
  │   │   └── admin_api.dart           ← Admin API calls
  │   ├── storage/
  │   │   └── secure_storage.dart      ← JWT token storage (encrypted)
  │   └── notification/
  │       └── fcm_service.dart         ← Firebase messaging
  │
  ├── providers/                       ← State management (Provider)
  │   ├── auth_provider.dart           ← Auth state (login, logout, user data)
  │   ├── business_provider.dart       ← Business profile state
  │   ├── customer_provider.dart       ← Customer search state
  │   ├── report_provider.dart         ← Report state
  │   └── notification_provider.dart   ← Notification state
  │
  ├── screens/                         ← All screens (pages)
  │   ├── splash/
  │   │   └── splash_screen.dart
  │   ├── auth/
  │   │   ├── welcome_screen.dart
  │   │   ├── login_screen.dart
  │   │   ├── register_screen.dart
  │   │   └── verification_pending_screen.dart
  │   ├── home/
  │   │   └── home_screen.dart
  │   ├── business/
  │   │   ├── business_register_screen.dart
  │   │   └── business_profile_screen.dart
  │   ├── customer/
  │   │   ├── customer_search_screen.dart
  │   │   └── customer_detail_screen.dart
  │   ├── report/
  │   │   ├── create_report_screen.dart
  │   │   ├── my_reports_screen.dart
  │   │   └── report_detail_screen.dart
  │   └── notification/
  │       └── notifications_screen.dart
  │
  ├── widgets/                         ← Reusable UI components
  │   ├── common/
  │   │   ├── custom_button.dart       ← Primary/Secondary/Outline buttons
  │   │   ├── custom_text_field.dart   ← Styled input field with validation
  │   │   ├── custom_app_bar.dart      ← Consistent app bar
  │   │   ├── loading_widget.dart      ← Spinner/Skeleton loader
  │   │   ├── error_widget.dart        ← Error display with retry
  │   │   ├── empty_state_widget.dart  ← "No data found" widget
  │   │   ├── status_badge.dart        ← Colored status chips
  │   │   └── confirm_dialog.dart      ← Confirmation popup
  │   ├── report/
  │   │   └── report_card.dart         ← Report list item card
  │   └── customer/
  │       └── customer_card.dart       ← Customer search result card
  │
  └── utils/                           ← Utility functions
      ├── validators.dart              ← Form validation functions
      ├── formatters.dart              ← Date, phone, currency formatters
      ├── constants.dart               ← String constants, enums
      └── helpers.dart                 ← General utility functions
  ```

### Step 1.12: Install Flutter Dependencies
- [x] Add dependencies to `pubspec.yaml`: ✅
  ```yaml
  dependencies:
    flutter:
      sdk: flutter
    
    # State Management
    provider: ^6.1.0
    
    # Networking
    dio: ^5.4.0                    # HTTP client (better than http package)
    
    # Local Storage
    flutter_secure_storage: ^9.0.0  # Encrypted storage for JWT tokens
    shared_preferences: ^2.2.0      # Simple key-value storage
    
    # UI/UX
    google_fonts: ^6.1.0            # Custom fonts
    flutter_svg: ^2.0.0             # SVG support
    cached_network_image: ^3.3.0    # Image caching
    shimmer: ^3.0.0                 # Skeleton loading effect
    fluttertoast: ^8.2.0            # Toast messages
    
    # Forms & Validation
    intl: ^0.19.0                   # Date/Number formatting
    
    # File Picking
    image_picker: ^1.0.0            # Camera/Gallery image pick
    file_picker: ^8.0.0             # Document file pick
    
    # Firebase (Phase 7, install now to avoid conflicts later)
    firebase_core: ^2.25.0
    firebase_messaging: ^14.7.0
    
    # Navigation
    go_router: ^13.0.0              # Advanced routing
  ```
- [ ] Run: `flutter pub get`

### Step 1.13: App Theme & Design System
- [x] Create `app_colors.dart`: ✅
  ```dart
  // Professional dark + accent color scheme
  // Primary: Deep Blue (#1A237E → #3949AB)
  // Accent: Amber/Gold (#FFB300)
  // Background: Near-white (#F5F5F7)
  // Error: Soft Red (#E53935)
  // Success: Green (#43A047)
  // Warning: Orange (#FB8C00)
  // Surface: White (#FFFFFF)
  // Text Primary: Dark (#1A1A2E)
  // Text Secondary: Grey (#6B7280)
  ```
- [x] Create `app_theme.dart`: ✅
  - Light theme (primary)
  - Dark theme (optional, future)
  - Custom button themes
  - Input decoration theme (consistent text fields)
  - Card theme
  - AppBar theme
- [x] Create `app_text_styles.dart`: ✅
  - Heading 1-4
  - Body large/medium/small
  - Caption
  - Button text
  - All using Google Fonts (Inter ya Outfit)
- [ ] Create `app_dimensions.dart`:
  - Padding: xs(4), sm(8), md(16), lg(24), xl(32)
  - Radius: sm(8), md(12), lg(16), xl(24)
  - Icon sizes
  - Font sizes

### Step 1.14: API Client Setup (Dio)
- [x] Create `api_client.dart`: ✅
  ```dart
  // Base Dio instance with:
  // - Base URL from config
  // - Timeout: 30 seconds
  // - Request interceptor: Auto-attach JWT token from secure storage
  // - Response interceptor: Log responses
  // - Error interceptor: Handle 401 (auto-refresh token), 
  //                      500 (server error), 
  //                      network errors (no internet)
  ```
- [x] Create `api_endpoints.dart`: ✅
  ```dart
  class ApiEndpoints {
    static const String baseUrl = 'http://10.0.2.2:3000/api/v1'; // Android emulator → localhost
    // For physical device: use your laptop's local IP (192.168.x.x)
    
    // Auth
    static const String register = '/auth/register';
    static const String login = '/auth/login';
    static const String refreshToken = '/auth/refresh';
    static const String profile = '/auth/profile';
    
    // Business
    static const String businessRegister = '/business/register';
    static const String businessProfile = '/business/profile';
    static const String businessUploadProof = '/business/upload-proof';
    
    // Customers
    static const String customerSearch = '/customers/search';
    static const String customerDetail = '/customers'; // + /:id
    
    // Reports
    static const String reportCreate = '/reports';
    static const String myReports = '/reports/my-reports';
    static const String reportDetail = '/reports'; // + /:id
    static const String reportEvidence = '/reports'; // + /:id/evidence
  }
  ```
- [x] Create `api_exceptions.dart`: ✅
  ```dart
  // Custom exceptions:
  // - NetworkException (no internet)
  // - ServerException (500)
  // - UnauthorizedException (401)
  // - ValidationException (400 with field errors)
  // - NotFoundException (404)
  // - TimeoutException
  ```

### Step 1.15: Secure Storage Setup
- [x] Create `secure_storage.dart`: ✅
  ```dart
  // Methods:
  // - saveAccessToken(String token)
  // - saveRefreshToken(String token)
  // - getAccessToken() → String?
  // - getRefreshToken() → String?
  // - deleteTokens()
  // - saveUserData(UserModel user)
  // - getUserData() → UserModel?
  // - clearAll()
  ```

### Step 1.16: API Response Model
- [x] Create `api_response_model.dart`: ✅
  ```dart
  // Matches backend response format:
  class ApiResponse<T> {
    final bool success;
    final int statusCode;
    final String message;
    final T? data;
    final List<String>? errors;
    final PaginationMeta? meta;
  }
  
  class PaginationMeta {
    final int total;
    final int page;
    final int limit;
    final int totalPages;
    final bool hasNextPage;
    final bool hasPrevPage;
  }
  ```

### Step 1.17: Reusable Widgets Create
- [x] Create `custom_button.dart`: ✅
  - Primary button (filled, primary color)
  - Secondary button (outlined)
  - Loading state (spinner inside button)
  - Disabled state
  - Full width option
- [x] Create `custom_text_field.dart`: ✅
  - Label, hint, prefix/suffix icons
  - Validation error display
  - Password field (obscure toggle)
  - Phone number field
  - Multi-line field
- [x] Create `loading_widget.dart`: ✅
  - Full screen loader
  - Inline loader
  - Shimmer skeleton (for lists)
- [x] Create `error_widget.dart`: ✅
  - Error message + Retry button
  - Network error variant
- [x] Create `empty_state_widget.dart`: ✅
  - Icon + Message + Optional action button
- [x] Create `status_badge.dart`: ✅
  - Colored chip: Pending(yellow), Approved(green), Rejected(red), Under Review(blue)

### Step 1.18: Basic Navigation Setup (GoRouter)
- [x] Create `routes.dart`: ✅
  ```dart
  // Route names:
  // /splash
  // /welcome
  // /login
  // /register
  // /verification-pending
  // /home
  // /business/register
  // /business/profile
  // /customer/search
  // /customer/:id
  // /report/create
  // /report/my-reports
  // /report/:id
  // /notifications
  
  // Auth redirect logic:
  // - No token → /welcome
  // - Token + not verified → /verification-pending
  // - Token + verified → /home
  ```

### Step 1.19: Main App Entry Point
- [x] Configure `main.dart`: ✅
  ```dart
  void main() async {
    WidgetsFlutterBinding.ensureInitialized();
    // Firebase.initializeApp() — Phase 7 mein enable karenge
    runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => AuthProvider()),
          // ... other providers
        ],
        child: MyBadCustomerApp(),
      ),
    );
  }
  
  class MyBadCustomerApp extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
      return MaterialApp.router(
        title: 'My Bad Customer',
        theme: AppTheme.lightTheme,
        routerConfig: AppRouter.router,
        debugShowCheckedModeBanner: false,
      );
    }
  }
  ```

### Step 1.20: Flutter Foundation Verify
- [x] App start ho bina error ke ✅
- [x] Theme/colors apply ho ✅
- [x] Navigation setup work kare (splash → welcome) ✅
- [x] Git commit: `git commit -m "Phase 1B: Flutter foundation setup"` ✅

### ✅ Phase 1 Verification Checklist:
- [x] Backend starts with no errors, global filters/interceptors working ✅
- [x] Prisma connected to PostgreSQL ✅
- [x] Flutter app starts with custom theme ✅
- [x] Folder structure complete for both projects ✅
- [x] Reusable widgets created and rendering correctly ✅
- [x] API client configured (Dio) ✅
- [x] Environment variables setup ✅

---

# ═══════════════════════════════════════════
# PHASE 2: AUTHENTICATION SYSTEM
# ═══════════════════════════════════════════

**Goal:** Complete auth system — Register, Login, JWT Access + Refresh Tokens, Profile, Guards, Auto-login, Logout

> [!IMPORTANT]
> Auth system production-ready hona chahiye kyunki poore app ki security iss pe depend karti hai. Hum Access Token (short-lived, 15min) + Refresh Token (long-lived, 7 days) pattern use karenge.

### 🎓 Learning:
> **JWT (JSON Web Token):** Login ke baad server ek token deta hai. Har API call mein ye token header mein bhejte ho. Server token se verify karta hai ki tum kaun ho — isse bar bar login nahi karna padta.
>
> **Access Token vs Refresh Token:**
> - Access Token = short life (15 min) — har API call mein use hota hai
> - Refresh Token = long life (7 days) — Access Token expire hone pe naya Access Token lene ke liye use hota hai
> - Ye pattern security ke liye hai — agar Access Token leak ho bhi jaaye to 15 min mein expire ho jayega
>
> **Hashing:** Password kabhi plain text store nahi hota. `bcrypt` se hash karte hain — irreversible hai.
>
> **Guards (NestJS):** Middleware jaisa hai — route pe aane se pehle check karta hai ki user authenticated hai ya nahi. `@UseGuards(JwtAuthGuard)` lagao — protected ho gaya.
>
> **Provider (Flutter):** React ka Context API + useState ka combination. Ek class banate ho jo state hold karti hai, ChangeNotifier extend karti hai, notifyListeners() call karte ho → UI automatically update hota hai.

---

## 2A — Backend: Auth Module

### Step 2.1: Complete Prisma Schema for Auth
- [x] `prisma/schema.prisma` mein add karo: ✅
  ```prisma
  model User {
    id                  String              @id @default(uuid())
    fullName            String
    email               String              @unique
    phone               String              @unique
    password            String              // bcrypt hashed
    role                Role                @default(BUSINESS_OWNER)
    isActive            Boolean             @default(true)
    verificationStatus  VerificationStatus  @default(PENDING)
    refreshToken        String?             // hashed refresh token
    lastLoginAt         DateTime?
    createdAt           DateTime            @default(now())
    updatedAt           DateTime            @updatedAt

    business            Business?
    reports             Report[]
    fcmTokens           FcmToken[]
    notifications       Notification[]
  }

  enum Role {
    BUSINESS_OWNER
    ADMIN
  }

  enum VerificationStatus {
    PENDING
    UNDER_REVIEW
    APPROVED
    REJECTED
  }
  ```
- [x] Run: `npx prisma db push` ✅
- [x] Verify table created ✅

### Step 2.2: Create Auth DTOs (Data Transfer Objects)
- [x] Create `dto/register.dto.ts`: ✅
  ```typescript
  // Validation rules:
  // fullName: required, string, min 2, max 100
  // email: required, valid email format
  // phone: required, valid Indian phone (10 digits)
  // password: required, min 8, must contain: uppercase, lowercase, number
  // confirmPassword: required, must match password
  ```
- [x] Create `dto/login.dto.ts`: ✅
  ```typescript
  // emailOrPhone: required, string
  // password: required, string
  ```
- [x] Create `dto/refresh-token.dto.ts`: ✅
  ```typescript
  // refreshToken: required, string
  ```

### Step 2.3: Auth Service Implementation
- [x] Create `auth.service.ts` with methods: ✅
  ```
  register(registerDto):
    1. Check if email already exists → throw ConflictException
    2. Check if phone already exists → throw ConflictException
    3. Hash password with bcrypt (salt rounds: 12)
    4. Create user in database
    5. Generate access token + refresh token
    6. Hash and save refresh token in database
    7. Return { user, accessToken, refreshToken }

  login(loginDto):
    1. Find user by email or phone
    2. If not found → throw UnauthorizedException("Invalid credentials")
    3. Compare password with bcrypt
    4. If wrong → throw UnauthorizedException("Invalid credentials")
    5. Check if user isActive → throw ForbiddenException if deactivated
    6. Generate new access token + refresh token
    7. Update refresh token in database
    8. Update lastLoginAt
    9. Return { user, accessToken, refreshToken }

  refreshToken(refreshTokenDto):
    1. Verify refresh token JWT
    2. Find user by id from token payload
    3. Compare hashed refresh token from database
    4. Generate new access token
    5. Return { accessToken }

  logout(userId):
    1. Remove refresh token from database
    2. Return { message: "Logged out successfully" }

  getProfile(userId):
    1. Find user by id
    2. Include business relation (if exists)
    3. Return user data (exclude password, refreshToken)
  ```

### Step 2.4: JWT Strategy & Guard
- [x] Create `strategies/jwt.strategy.ts`: ✅
  ```typescript
  // Extract JWT from Authorization header (Bearer token)
  // Validate token → return user payload { id, email, role }
  ```
- [x] Create `guards/jwt-auth.guard.ts`: ✅
  ```typescript
  // Use JwtStrategy to validate
  // If invalid/expired → 401 Unauthorized
  ```
- [x] Create `guards/roles.guard.ts`: ✅
  ```typescript
  // Check user role against required roles
  // Usage: @Roles(Role.ADMIN) + @UseGuards(JwtAuthGuard, RolesGuard)
  ```
- [x] Create `decorators/current-user.decorator.ts`: ✅
  ```typescript
  // Custom decorator to get current user from request
  // Usage: @CurrentUser() user: User
  ```

### Step 2.5: Auth Controller
- [x] Create `auth.controller.ts`: ✅
  ```
  POST   /api/v1/auth/register     → register() [Public]
  POST   /api/v1/auth/login        → login()    [Public]
  POST   /api/v1/auth/refresh      → refreshToken() [Public]
  POST   /api/v1/auth/logout       → logout()   [Protected - JWT]
  GET    /api/v1/auth/profile      → getProfile() [Protected - JWT]
  ```

### Step 2.6: Auth Module Wire Up
- [x] Import/Export in `app.module.ts` ✅:
  - Import: JwtModule, PassportModule, PrismaModule
  - Providers: AuthService, JwtStrategy
  - Controllers: AuthController
  - Export: AuthService, JwtModule

### Step 2.7: Create Initial Admin User (Seed)
- [x] Create `prisma/seed.ts`: ✅
  ```typescript
  // Create default admin user:
  // email: admin@mybadcustomer.com
  // password: Admin@123456 (hashed)
  // role: ADMIN
  // verificationStatus: APPROVED
  ```
- [x] Add seed script to `package.json`: ✅
  ```json
  "prisma": { "seed": "ts-node prisma/seed.ts" }
  ```
- [x] Run: `npx prisma db seed` ✅

### Step 2.8: Backend Auth Testing
- [x] Test Register: ✅
  ```
  POST http://localhost:3000/api/v1/auth/register
  Body: { fullName, email, phone, password, confirmPassword }
  Expected: 201 → { user, accessToken, refreshToken }
  ```
- [x] Test Register Validation: ✅
  ```
  - Missing fields → 400 with specific field errors
  - Duplicate email → 409 Conflict
  - Duplicate phone → 409 Conflict
  - Weak password → 400 validation error
  ```
- [x] Test Login: ✅
  ```
  POST http://localhost:3000/api/v1/auth/login
  Body: { emailOrPhone, password }
  Expected: 200 → { user, accessToken, refreshToken }
  ```
- [x] Test Login Validation: ✅
  ```
  - Wrong email → 401 "Invalid credentials"
  - Wrong password → 401 "Invalid credentials"
  - Deactivated user → 403 Forbidden
  ```
- [x] Test Protected Route: ✅
  ```
  GET http://localhost:3000/api/v1/auth/profile
  Header: Authorization: Bearer <access_token>
  Expected: 200 → user data
  Without token: 401 Unauthorized
  ```
- [ ] Test Refresh Token:
  ```
  POST http://localhost:3000/api/v1/auth/refresh
  Body: { refreshToken }
  Expected: 200 → { accessToken }
  ```
- [ ] Test Logout:
  ```
  POST http://localhost:3000/api/v1/auth/logout
  Header: Authorization: Bearer <access_token>
  Expected: 200 → "Logged out"
  ```
- [ ] ✅ **Checkpoint:** All auth APIs working correctly with proper validation and error handling

---

## 2B — Flutter: Auth Screens

### Step 2.9: User Model Create
- [ ] Create `models/user_model.dart`:
  ```dart
  class UserModel {
    final String id;
    final String fullName;
    final String email;
    final String phone;
    final String role;
    final String verificationStatus;
    final bool isActive;
    final DateTime createdAt;
    final BusinessModel? business;
    
    // fromJson() factory constructor
    // toJson() method
  }
  ```

### Step 2.10: Auth API Service
- [ ] Create `services/api/auth_api.dart`:
  ```dart
  class AuthApi {
    final ApiClient _client;
    
    Future<ApiResponse> register({fullName, email, phone, password});
    Future<ApiResponse> login({emailOrPhone, password});
    Future<ApiResponse> refreshToken(String refreshToken);
    Future<ApiResponse> logout();
    Future<ApiResponse> getProfile();
  }
  ```

### Step 2.11: Auth Provider (State Management)
- [ ] Create `providers/auth_provider.dart`:
  ```dart
  class AuthProvider extends ChangeNotifier {
    UserModel? _user;
    bool _isLoading = false;
    String? _error;
    bool _isAuthenticated = false;
    
    // Getters for all state
    
    Future<bool> register(RegisterData data);
    // 1. Call AuthApi.register()
    // 2. Save tokens to SecureStorage
    // 3. Set _user
    // 4. Set _isAuthenticated = true
    // 5. notifyListeners()
    
    Future<bool> login(String emailOrPhone, String password);
    // Same flow as register
    
    Future<void> logout();
    // 1. Call AuthApi.logout()
    // 2. Clear SecureStorage
    // 3. Reset state
    // 4. notifyListeners()
    
    Future<void> checkAuthStatus();
    // 1. Check SecureStorage for token
    // 2. If token exists → getProfile()
    // 3. If 401 → try refresh → if fail → logout
    // Called on app start (splash screen)
    
    void clearError();
  }
  ```

### Step 2.12: Splash Screen
- [ ] Create `screens/splash/splash_screen.dart`:
  ```
  - App logo center mein
  - 2 second delay
  - AuthProvider.checkAuthStatus() call
  - If authenticated + verified → Navigate to /home
  - If authenticated + not verified → Navigate to /verification-pending
  - If not authenticated → Navigate to /welcome
  ```

### Step 2.13: Welcome Screen
- [ ] Create `screens/auth/welcome_screen.dart`:
  ```
  - App logo (top)
  - App name: "My Bad Customer" (large text)
  - Tagline: "Protect your business from bad customers"
  - "Get Started" button → Navigate to /register
  - "Already have an account? Login" link → Navigate to /login
  - Clean, professional design with gradient background
  ```

### Step 2.14: Registration Screen
- [ ] Create `screens/auth/register_screen.dart`:
  ```
  Form Fields:
  - Full Name (TextInput, validation: required, min 2 chars)
  - Email (TextInput, validation: required, valid email format)
  - Phone Number (TextInput, validation: required, 10 digits, numeric keyboard)
  - Password (PasswordInput, validation: required, min 8, uppercase+lowercase+number)
  - Confirm Password (PasswordInput, validation: must match password)
  
  Button:
  - "Register" (loading state while API call)
  
  Navigation:
  - "Already have an account? Login" link
  
  Error Handling:
  - Field-level validation errors (inline below each field)
  - API errors (SnackBar/Toast: "Email already exists", etc.)
  - Network errors ("No internet connection. Please try again.")
  
  Success:
  - Navigate to /verification-pending
  ```

### Step 2.15: Login Screen
- [ ] Create `screens/auth/login_screen.dart`:
  ```
  Form Fields:
  - Email or Phone (TextInput, validation: required)
  - Password (PasswordInput, validation: required)
  
  Button:
  - "Login" (loading state)
  
  Navigation:
  - "Don't have an account? Register" link
  
  Error Handling:
  - "Invalid credentials" (API 401)
  - "Account deactivated" (API 403)
  - Network errors
  
  Success:
  - If verified → Navigate to /home
  - If not verified → Navigate to /verification-pending
  ```

### Step 2.16: Verification Pending Screen
- [ ] Create `screens/auth/verification_pending_screen.dart`:
  ```
  - Information icon/illustration
  - Title: "Verification Pending"
  - Message: "Your account is under verification. You will be notified once approved."
  - Show current status badge: PENDING / UNDER_REVIEW / REJECTED
  - If REJECTED: Show "Your verification was rejected. Please contact support."
  - "Refresh Status" button → re-fetch profile
  - "Logout" button
  ```

### Step 2.17: Form Validators
- [ ] Create `utils/validators.dart`:
  ```dart
  class Validators {
    static String? validateName(String? value);
    static String? validateEmail(String? value);
    static String? validatePhone(String? value);
    static String? validatePassword(String? value);
    static String? validateConfirmPassword(String? value, String password);
    static String? validateRequired(String? value, String fieldName);
  }
  ```

### Step 2.18: Flutter Auth Integration Test
- [ ] Start NestJS backend: `npm run start:dev`
- [ ] Start Flutter app: `flutter run`
- [ ] Test complete flow:
  ```
  1. App opens → Splash → Welcome screen
  2. Tap "Get Started" → Register screen
  3. Fill form with valid data → Tap "Register"
  4. Successful → Verification Pending screen appears
  5. Tap "Logout" → Back to Welcome
  6. Tap "Login" → Login with same credentials
  7. Successful → Verification Pending screen (kyunki abhi admin ne verify nahi kiya)
  8. Close app → Reopen → Splash → Auto-login → Verification Pending
  ```
- [ ] Test error scenarios:
  ```
  - Register with existing email → Error toast
  - Login with wrong password → Error toast
  - Empty form submit → Field validation errors
  - Turn off backend → Network error
  ```

### ✅ Phase 2 Verification Checklist:
- [ ] Register API + Flutter screen working ✅
- [ ] Login API + Flutter screen working ✅
- [ ] JWT Access + Refresh token working ✅
- [ ] Auto-login on app restart working ✅
- [ ] Logout clears tokens and redirects ✅
- [ ] Form validation (frontend + backend) working ✅
- [ ] Error handling (network, validation, auth) working ✅
- [ ] Admin seed user created ✅
- [ ] Git commit: `"Phase 2: Authentication system complete"` ✅

---

# ═══════════════════════════════════════════
# PHASE 3: BUSINESS PROFILE & VERIFICATION
# ═══════════════════════════════════════════

**Goal:** Business Owner apni business info + proof submit kare → Admin review & approve/reject kare → Status update ho

### 🎓 Learning:
> **File Upload Flow (Production):**
> 1. Flutter mein user file select karta hai (image_picker/file_picker)
> 2. File backend pe multipart/form-data mein jaati hai
> 3. Backend file ko Cloudinary pe upload karta hai (SDK use karke)
> 4. Cloudinary ek secure URL return karta hai
> 5. URL database mein store hota hai
> 6. Direct Cloudinary pe Flutter se upload nahi karenge — security ke liye backend se karenge
>
> **Multipart Form Data:** Jaise web mein `<form enctype="multipart/form-data">` hota hai — same concept. Binary files ko HTTP mein bhejne ka standard way.

---

## 3A — Backend: Business & Cloudinary Module

### Step 3.1: Cloudinary Service Setup
- [ ] Create `cloudinary/cloudinary.module.ts`
- [ ] Create `cloudinary/cloudinary.service.ts`:
  ```typescript
  // Methods:
  // uploadFile(file: Express.Multer.File, folder: string): Promise<CloudinaryResponse>
  //   → Upload to specific folder (e.g., 'business-proofs', 'evidence')
  //   → Return { url, publicId, format, size }
  //
  // deleteFile(publicId: string): Promise<void>
  //   → Delete file from Cloudinary
  //
  // Configuration from .env variables
  ```
- [ ] Test Cloudinary connection — upload a test image and verify

### Step 3.2: Business Schema (Prisma)
- [ ] Add to `schema.prisma`:
  ```prisma
  model Business {
    id              String   @id @default(uuid())
    userId          String   @unique
    user            User     @relation(fields: [userId], references: [id], onDelete: Cascade)
    businessName    String
    businessType    String
    businessCategory String?
    ownerName       String
    address         String
    city            String
    state           String
    pincode         String
    gstNumber       String?
    panNumber       String?
    businessProofUrl String?            // Cloudinary URL
    businessProofPublicId String?       // For deletion
    additionalInfo  String?
    rejectionReason String?             // If admin rejects
    verifiedAt      DateTime?
    verifiedBy      String?             // Admin user ID
    createdAt       DateTime @default(now())
    updatedAt       DateTime @updatedAt
  }
  ```
- [ ] Run: `npx prisma migrate dev --name add_business_table`

### Step 3.3: Business DTOs
- [ ] Create `dto/create-business.dto.ts`:
  ```typescript
  // Validation:
  // businessName: required, string, min 2, max 200
  // businessType: required, string (enum: RETAIL, WHOLESALE, SERVICE, AGRICULTURE, TRADING, MANUFACTURING, OTHER)
  // ownerName: required, string, min 2, max 100
  // address: required, string, min 10, max 500
  // city: required, string
  // state: required, string
  // pincode: required, string, exactly 6 digits
  // gstNumber: optional, valid GST format (15 chars)
  // panNumber: optional, valid PAN format (10 chars)
  // additionalInfo: optional, max 1000 chars
  ```
- [ ] Create `dto/update-business.dto.ts` (PartialType of create)
- [ ] Create `dto/verify-business.dto.ts`:
  ```typescript
  // action: required, enum (APPROVE, REJECT)
  // rejectionReason: required if action is REJECT, string, min 10
  ```

### Step 3.4: Business Service
- [ ] Create `business/business.service.ts`:
  ```
  createBusiness(userId, dto, proofFile?):
    1. Check user doesn't already have a business → ConflictException
    2. If proofFile → upload to Cloudinary (folder: 'business-proofs')
    3. Create business record in DB
    4. Update user verificationStatus to PENDING
    5. Return business

  getMyBusiness(userId):
    1. Find business by userId
    2. If not found → NotFoundException
    3. Return business with user info

  updateBusiness(userId, dto):
    1. Find business by userId
    2. If verificationStatus is APPROVED → throw "Cannot modify verified business"
    3. Update business
    4. Reset verificationStatus to PENDING
    5. Return updated business

  uploadProof(userId, file):
    1. Find business by userId
    2. If old proof exists → delete from Cloudinary
    3. Upload new file to Cloudinary
    4. Update business with new URL
    5. Return updated business

  // Admin methods:
  getAllBusinesses(paginationDto, filters):
    1. Query with filters (status, search)
    2. Include user relation
    3. Return paginated results

  getBusinessById(businessId):
    1. Find by id
    2. Include user relation
    3. Return business

  verifyBusiness(businessId, verifyDto, adminUserId):
    1. Find business
    2. If already approved → throw "Already verified"
    3. If action is APPROVE:
       - Update verificationStatus to APPROVED
       - Set verifiedAt, verifiedBy
       - Update user.verificationStatus to APPROVED
    4. If action is REJECT:
       - Update verificationStatus to REJECTED
       - Set rejectionReason
       - Update user.verificationStatus to REJECTED
    5. Return business
    6. (Phase 7: Trigger notification)
  ```

### Step 3.5: Business Controller
- [ ] Create `business/business.controller.ts`:
  ```
  POST   /api/v1/business          → createBusiness()     [Protected - JWT]
  GET    /api/v1/business/my       → getMyBusiness()      [Protected - JWT]
  PUT    /api/v1/business/update   → updateBusiness()     [Protected - JWT]
  POST   /api/v1/business/proof    → uploadProof()        [Protected - JWT, Multipart]
  ```
- [ ] Create `admin/admin.controller.ts` (business section):
  ```
  GET    /api/v1/admin/businesses           → getAllBusinesses()    [Protected - ADMIN]
  GET    /api/v1/admin/businesses/:id       → getBusinessById()    [Protected - ADMIN]
  PATCH  /api/v1/admin/businesses/:id/verify → verifyBusiness()    [Protected - ADMIN]
  ```

### Step 3.6: Multer Config for File Upload
- [ ] Create file upload configuration:
  ```typescript
  // Max file size: 5MB
  // Allowed types: image/jpeg, image/png, image/webp, application/pdf
  // Use memory storage (buffer → Cloudinary)
  ```
- [ ] Apply to upload routes using @UseInterceptors(FileInterceptor)

### Step 3.7: Backend Business API Testing
- [ ] Test Create Business (with and without proof file)
- [ ] Test Upload Proof (valid file, invalid file type, too large file)
- [ ] Test Get My Business (own data)
- [ ] Test Update Business (modify and re-submit)
- [ ] Test Admin: Get all pending businesses (paginated)
- [ ] Test Admin: Verify (approve) a business
- [ ] Test Admin: Reject a business with reason
- [ ] Test access control (non-admin can't access admin routes)

---

## 3B — Flutter: Business Profile Screens

### Step 3.8: Business Model
- [ ] Create `models/business_model.dart`:
  ```dart
  class BusinessModel {
    final String id;
    final String businessName;
    final String businessType;
    final String ownerName;
    final String address;
    final String city;
    final String state;
    final String pincode;
    final String? gstNumber;
    final String? panNumber;
    final String? businessProofUrl;
    final String verificationStatus;
    final String? rejectionReason;
    final DateTime createdAt;
    // fromJson, toJson
  }
  ```

### Step 3.9: Business Provider
- [ ] Create `providers/business_provider.dart`:
  ```dart
  class BusinessProvider extends ChangeNotifier {
    BusinessModel? _business;
    bool _isLoading = false;
    String? _error;
    
    Future<bool> registerBusiness(BusinessData data, File? proofFile);
    Future<void> fetchMyBusiness();
    Future<bool> updateBusiness(BusinessData data);
    Future<bool> uploadProof(File file);
  }
  ```

### Step 3.10: Business Registration Screen
- [ ] Create `screens/business/business_register_screen.dart`:
  ```
  Multi-section form:
  
  Section 1: Business Information
  - Business Name (required)
  - Business Type (Dropdown: Retail, Wholesale, Service, Agriculture, Trading, Manufacturing, Other)
  - Owner Name (required)
  
  Section 2: Address
  - Address (required, multiline)
  - City (required)
  - State (Dropdown: all Indian states)
  - Pincode (required, 6 digits)
  
  Section 3: Documents (Optional)
  - GST Number (optional, format validation)
  - PAN Number (optional, format validation)
  
  Section 4: Business Proof
  - Upload button → open file picker (image/pdf)
  - Preview selected file (image thumbnail or PDF icon)
  - Remove selected file option
  
  Section 5: Additional Info
  - TextArea (optional, max 1000 chars)
  
  Submit Button:
  - "Submit for Verification" (loading state)
  - On success → Navigate to Verification Pending
  
  Error Handling:
  - Field validation errors
  - File too large error
  - API errors
  ```

### Step 3.11: Business Profile Screen
- [ ] Create `screens/business/business_profile_screen.dart`:
  ```
  - Display all business info in cards
  - Verification Status Badge (prominent, top)
  - If REJECTED: Show rejection reason in red card
  - If PENDING/UNDER_REVIEW: Show waiting message
  - If APPROVED: Show verified badge with green checkmark
  - "Edit" button (only if not APPROVED)
  - Proof image preview (if uploaded)
  ```

### Step 3.12: Update Auth Flow for Business
- [ ] After login/auto-login:
  ```
  Check user.verificationStatus:
  - PENDING + no business → Navigate to Business Registration
  - PENDING + has business → Navigate to Verification Pending
  - UNDER_REVIEW → Verification Pending
  - REJECTED → Verification Pending (with rejection reason)
  - APPROVED → Home Screen
  ```

### Step 3.13: Flutter Business Integration Test
- [ ] Register new user → Fill business form → Submit
- [ ] Check Cloudinary dashboard → proof file uploaded
- [ ] Check database → business record created
- [ ] Login as admin (Postman) → call verify API → approve business
- [ ] Refresh app → User now goes to Home Screen
- [ ] Test rejection flow → rejection reason displays correctly

### ✅ Phase 3 Verification Checklist:
- [ ] Business registration form works with file upload ✅
- [ ] Cloudinary stores files correctly ✅
- [ ] Admin can see pending businesses ✅
- [ ] Admin approve/reject works ✅
- [ ] User sees correct verification status ✅
- [ ] Rejection reason displays properly ✅
- [ ] Navigation flow correct based on verification status ✅
- [ ] Git commit: `"Phase 3: Business profile & verification complete"` ✅

---

# ═══════════════════════════════════════════
# PHASE 4: CUSTOMER MANAGEMENT & SEARCH
# ═══════════════════════════════════════════

**Goal:** Verified business owners can search for customers and see approved reports summary

> [!NOTE]
> Is phase se "verified business owner" guard lagega — sirf APPROVED status wale users hi customer features access kar sakenge.

### 🎓 Learning:
> **Search Implementation:** PostgreSQL mein `ILIKE` operator se case-insensitive search hoti hai. Prisma mein `contains` + `mode: 'insensitive'` use karenge.
>
> **Verified Guard:** Ek custom guard banayenge jo check karega ki user ka verificationStatus === APPROVED hai. Agar nahi to 403 Forbidden dega.

---

## 4A — Backend: Customer Module

### Step 4.1: Customer Schema (Prisma)
- [ ] Add to `schema.prisma`:
  ```prisma
  model Customer {
    id          String    @id @default(uuid())
    fullName    String
    phone       String
    normalizedPhone String     // Phone without +91, spaces, dashes
    addedBy     String         // First reporter's userId
    totalReports Int      @default(0)
    approvedReports Int   @default(0)
    createdAt   DateTime  @default(now())
    updatedAt   DateTime  @updatedAt
    
    reports     Report[]
    
    @@unique([normalizedPhone])
    @@index([fullName])
    @@index([normalizedPhone])
  }
  ```
- [ ] Run: `npx prisma migrate dev --name add_customer_table`

### Step 4.2: Verified Business Guard
- [ ] Create `common/guards/verified-business.guard.ts`:
  ```typescript
  // Check:
  // 1. User is authenticated (JWT)
  // 2. User role is BUSINESS_OWNER
  // 3. User verificationStatus is APPROVED
  // If any check fails → 403 Forbidden
  // Usage: @UseGuards(JwtAuthGuard, VerifiedBusinessGuard)
  ```

### Step 4.3: Customer DTOs
- [ ] Create `dto/search-customer.dto.ts`:
  ```typescript
  // name: optional, string, min 2
  // phone: optional, string, min 3
  // At least one of name or phone required
  // Extends PaginationDto
  ```
- [ ] Create `dto/create-customer.dto.ts`:
  ```typescript
  // fullName: required, string, min 2, max 100
  // phone: required, string, valid Indian phone
  ```

### Step 4.4: Customer Service
- [ ] Create `customers/customers.service.ts`:
  ```
  searchCustomers(searchDto):
    1. Build search query:
       - If name provided: fullName ILIKE '%name%'
       - If phone provided: normalizedPhone CONTAINS phone
    2. Only include customers with approvedReports > 0
    3. Paginate results
    4. Return { customers[], meta }
    5. Each customer includes: name, phone, totalApprovedReports, latestIssueTypes
    6. DO NOT include evidence or detailed report info

  getCustomerDetail(customerId, requestingUserId):
    1. Find customer by id
    2. Get approved reports for this customer
    3. For each report: show issueType, title, description, date, reporterBusinessName
    4. DO NOT show evidence (privacy)
    5. Show if requesting user has their own reports on this customer
    6. Return { customer, approvedReports[], hasOwnReport }

  createOrFindCustomer(dto):
    1. Normalize phone number
    2. Find existing customer by normalizedPhone
    3. If exists → return existing
    4. If not → create new customer
    5. Return customer
  ```

### Step 4.5: Customer Controller
- [ ] Create `customers/customers.controller.ts`:
  ```
  GET    /api/v1/customers/search        → searchCustomers()    [Verified Business]
  GET    /api/v1/customers/:id           → getCustomerDetail()  [Verified Business]
  ```

### Step 4.6: Phone Number Normalization Utility
- [ ] Create `common/utils/phone.utils.ts`:
  ```typescript
  // normalizePhone(phone: string): string
  // Remove: +91, 0, spaces, dashes, brackets
  // Keep: only 10 digits
  // Example: "+91-98765 43210" → "9876543210"
  ```

### Step 4.7: Backend Customer API Testing
- [ ] Test search by name (partial match works)
- [ ] Test search by phone (partial match works)
- [ ] Test search by name + phone combined
- [ ] Test pagination (page, limit)
- [ ] Test that only approved reports info shows
- [ ] Test that evidence is NOT included in response
- [ ] Test access control (non-verified user gets 403)
- [ ] Test empty search results

---

## 4B — Flutter: Customer Search Screens

### Step 4.8: Customer Model
- [ ] Create `models/customer_model.dart`:
  ```dart
  class CustomerModel {
    final String id;
    final String fullName;
    final String phone;
    final int approvedReports;
    final List<String> issueTypes; // For summary display
    final DateTime? lastReportDate;
    // fromJson
  }
  
  class CustomerDetailModel {
    final CustomerModel customer;
    final List<ApprovedReportSummary> reports;
    final bool hasOwnReport;
    // fromJson
  }
  
  class ApprovedReportSummary {
    final String issueType;
    final String title;
    final String description;
    final String reporterBusinessName;
    final DateTime reportDate;
    // fromJson — no evidence fields
  }
  ```

### Step 4.9: Customer Provider
- [ ] Create `providers/customer_provider.dart`

### Step 4.10: Home Screen (Dashboard)
- [ ] Create `screens/home/home_screen.dart`:
  ```
  - App bar with "My Bad Customer" title + notification icon
  - Welcome message: "Hello, {businessName}" with verified badge
  - Search card (prominent):
    - "Search Customer" with search icon
    - Tap → Navigate to search screen
  - Quick Actions:
    - "Report a Customer" → /report/create
    - "My Reports" → /report/my-reports
    - "My Business Profile" → /business/profile
  - Bottom Navigation Bar:
    - Home (active)
    - Search
    - Report
    - Profile
  ```

### Step 4.11: Customer Search Screen
- [ ] Create `screens/customer/customer_search_screen.dart`:
  ```
  - Search bar (top):
    - Two fields: Name, Phone
    - Search button
    - Clear button
  - Results area:
    - If searching → Loading shimmer
    - If results → List of CustomerCards
    - If no results → EmptyState: "No records found for this customer. This is a good sign!"
    - If error → ErrorWidget with retry
  - Each CustomerCard shows:
    - Customer name
    - Phone (partially masked: ****543210)
    - Total approved reports count
    - Issue types as colored chips
    - Tap → Navigate to customer detail
  - Pagination: "Load More" button at bottom (or infinite scroll)
  ```

### Step 4.12: Customer Detail Screen
- [ ] Create `screens/customer/customer_detail_screen.dart`:
  ```
  - Customer info card (top):
    - Full name
    - Phone (partially masked for non-reporters)
    - Total reports count
  - Reports list:
    - Each report card shows:
      - Issue Type badge
      - Title
      - Description
      - Reporter's business name
      - Date
    - NO evidence shown (privacy)
  - If user has own report on this customer:
    - Show "You have reported this customer" badge
  - "Report this Customer" FAB button → /report/create?customerId=xxx
  ```

### Step 4.13: Flutter Customer Integration Test
- [ ] Search by name → results show
- [ ] Search by phone → results show
- [ ] Customer detail shows only approved reports
- [ ] No evidence visible to other business owners
- [ ] Empty search shows positive message
- [ ] Pagination works
- [ ] Unverified user can't access search (guard check)

### ✅ Phase 4 Verification Checklist:
- [ ] Customer search works by name and phone ✅
- [ ] Only approved report summaries visible ✅
- [ ] Evidence not exposed to other business owners ✅
- [ ] Phone number partially masked ✅
- [ ] Pagination working ✅
- [ ] Verified business guard working ✅
- [ ] Home screen with navigation working ✅
- [ ] Git commit: `"Phase 4: Customer search & management complete"` ✅

---

# ═══════════════════════════════════════════
# PHASE 5: CUSTOMER REPORTING & EVIDENCE
# ═══════════════════════════════════════════

**Goal:** Verified business owner can submit detailed report against a customer with multiple evidence files, track report status, respond to admin's "more info" requests

### 🎓 Learning:
> **Multi-file Upload:** Har evidence file ek-ek karke Cloudinary pe upload hoti hai. Har upload ka URL database mein store hota hai. Ek report ke saath multiple Evidence records linked hote hain (1-to-many relationship).
>
> **Report Status Flow:**
> ```
> PENDING → UNDER_REVIEW → APPROVED
>                        → REJECTED
>                        → MORE_INFO_REQUIRED → (user updates) → PENDING (cycle back)
> ```

---

## 5A — Backend: Reports & Evidence Module

### Step 5.1: Report & Evidence Schema (Prisma)
- [ ] Add to `schema.prisma`:
  ```prisma
  model Report {
    id              String       @id @default(uuid())
    customerId      String
    customer        Customer     @relation(fields: [customerId], references: [id])
    reporterId      String
    reporter        User         @relation(fields: [reporterId], references: [id])
    issueType       IssueType
    title           String
    description     String       @db.Text
    amount          Decimal?     // Financial loss amount (optional)
    incidentDate    DateTime?    // When the incident happened
    status          ReportStatus @default(PENDING)
    adminNotes      String?      @db.Text
    adminId         String?      // Reviewing admin
    reviewedAt      DateTime?
    moreInfoRequest String?      @db.Text  // What info admin needs
    moreInfoResponse String?     @db.Text  // User's response
    createdAt       DateTime     @default(now())
    updatedAt       DateTime     @updatedAt
    
    evidence        Evidence[]
  }

  model Evidence {
    id              String   @id @default(uuid())
    reportId        String
    report          Report   @relation(fields: [reportId], references: [id], onDelete: Cascade)
    fileUrl         String
    filePublicId    String   // Cloudinary public_id for deletion
    fileType        String   // image/jpeg, image/png, application/pdf
    fileName        String
    fileSize        Int      // bytes
    uploadedAt      DateTime @default(now())
  }

  enum IssueType {
    FRAUD
    PAYMENT_ISSUE
    LATE_PAYMENT
    FAKE_ORDER
    ORDER_CANCELLATION
    FINANCIAL_LOSS
    TIME_LOSS
    MISLEADING_INFO
    OTHER
  }

  enum ReportStatus {
    PENDING
    UNDER_REVIEW
    MORE_INFO_REQUIRED
    APPROVED
    REJECTED
  }
  ```
- [ ] Run: `npx prisma migrate dev --name add_report_evidence_tables`

### Step 5.2: Report DTOs
- [ ] Create `dto/create-report.dto.ts`:
  ```typescript
  // customerId: optional (if existing customer)
  // customerName: required if no customerId
  // customerPhone: required if no customerId
  // issueType: required, enum IssueType
  // title: required, string, min 5, max 200
  // description: required, string, min 20, max 5000
  // amount: optional, number, min 0
  // incidentDate: optional, valid date, not in future
  ```
- [ ] Create `dto/update-report.dto.ts` (for more info response)
- [ ] Create `dto/review-report.dto.ts`:
  ```typescript
  // action: required, enum (APPROVE, REJECT, REQUEST_MORE_INFO)
  // adminNotes: optional, string
  // moreInfoRequest: required if action is REQUEST_MORE_INFO
  // rejectionReason included in adminNotes if REJECT
  ```

### Step 5.3: Report Service
- [ ] Create `reports/reports.service.ts`:
  ```
  createReport(reporterId, dto):
    1. Verify reporter is verified business owner
    2. If customerId → find customer
    3. If no customerId → createOrFindCustomer(name, phone)
    4. Check reporter hasn't already submitted report for same customer + same issueType
       → If duplicate → ConflictException "You've already reported this issue"
    5. Create Report record
    6. Increment customer.totalReports
    7. Return report

  uploadEvidence(reportId, userId, files[]):
    1. Verify report belongs to userId
    2. Verify report status is PENDING or MORE_INFO_REQUIRED
    3. Max 5 evidence files per report → check current count
    4. For each file:
       a. Validate file type and size (max 5MB each)
       b. Upload to Cloudinary (folder: 'evidence/{reportId}')
       c. Create Evidence record
    5. Return updated report with evidence

  getMyReports(userId, paginationDto, statusFilter?):
    1. Find all reports by reporterId = userId
    2. Include customer info
    3. Include evidence count (not URLs — show count only)
    4. Order by createdAt DESC
    5. Paginate
    6. Return { reports[], meta }

  getReportDetail(reportId, userId):
    1. Find report by id
    2. If reporter is userId → show full detail + own evidence URLs
    3. If not reporter → 403 Forbidden (use customer detail for approved summaries)
    4. Include customer, evidence
    5. Return report

  respondToMoreInfo(reportId, userId, response):
    1. Verify report belongs to userId
    2. Verify status is MORE_INFO_REQUIRED
    3. Update moreInfoResponse
    4. Update status back to PENDING
    5. Return report

  // Admin methods:
  getAllReports(paginationDto, filters):
    1. Filters: status, issueType, dateRange, search(customer name)
    2. Include customer, reporter.business, evidence count
    3. Paginate
    4. Return { reports[], meta }

  getReportForReview(reportId):
    1. Find report with ALL relations:
       - Customer
       - Reporter + Reporter.Business
       - Evidence (with URLs — admin can see)
    2. Return full report

  reviewReport(reportId, adminId, reviewDto):
    1. Find report
    2. If APPROVE:
       - Status → APPROVED
       - Set reviewedAt, adminId
       - Increment customer.approvedReports
    3. If REJECT:
       - Status → REJECTED
       - Set adminNotes, reviewedAt, adminId
    4. If REQUEST_MORE_INFO:
       - Status → MORE_INFO_REQUIRED
       - Set moreInfoRequest
    5. Return report
    6. (Phase 7: Trigger notification to reporter)
  ```

### Step 5.4: Evidence Service
- [ ] Create `evidence/evidence.service.ts`:
  ```
  uploadFiles(reportId, files[]): → upload each to Cloudinary, create records
  deleteEvidence(evidenceId, userId): → verify ownership, delete from Cloudinary + DB
  getEvidenceForAdmin(reportId): → return all evidence with URLs (admin only)
  ```

### Step 5.5: Report Controller
- [ ] Create `reports/reports.controller.ts`:
  ```
  POST   /api/v1/reports                      → createReport()       [Verified Business]
  POST   /api/v1/reports/:id/evidence          → uploadEvidence()     [Verified Business, Multipart]
  GET    /api/v1/reports/my-reports             → getMyReports()       [Verified Business]
  GET    /api/v1/reports/:id                    → getReportDetail()    [Verified Business]
  PUT    /api/v1/reports/:id/more-info-response → respondToMoreInfo()  [Verified Business]
  DELETE /api/v1/reports/:id/evidence/:evidenceId → deleteEvidence()   [Verified Business]
  ```
- [ ] Add admin routes in `admin.controller.ts`:
  ```
  GET    /api/v1/admin/reports                 → getAllReports()      [ADMIN]
  GET    /api/v1/admin/reports/:id             → getReportForReview() [ADMIN]
  PATCH  /api/v1/admin/reports/:id/review      → reviewReport()      [ADMIN]
  ```

### Step 5.6: Backend Report API Testing
- [ ] Test create report with new customer
- [ ] Test create report with existing customer
- [ ] Test duplicate report prevention
- [ ] Test upload 1 evidence file
- [ ] Test upload multiple evidence files (up to 5)
- [ ] Test upload 6th file → error
- [ ] Test invalid file type → error
- [ ] Test get my reports (paginated, filtered)
- [ ] Test report detail (own report)
- [ ] Test report detail (other's report) → 403
- [ ] Test admin: get all reports with filters
- [ ] Test admin: review → approve
- [ ] Test admin: review → reject
- [ ] Test admin: review → request more info
- [ ] Test user: respond to more info request
- [ ] Test evidence visible to admin, not to other users
- [ ] Verify customer.approvedReports increments on approve

---

## 5B — Flutter: Report Screens

### Step 5.7: Report & Evidence Models
- [ ] Create `models/report_model.dart`
- [ ] Create `models/evidence_model.dart`

### Step 5.8: Report Provider
- [ ] Create `providers/report_provider.dart`

### Step 5.9: Create Report Screen (Multi-Step)
- [ ] Create `screens/report/create_report_screen.dart`:
  ```
  Step 1: Customer Information
  - "Search Existing Customer" button
    → Opens search dialog → select customer
  - OR "Add New Customer"
    → Customer Name field
    → Customer Phone field
  - Next button

  Step 2: Issue Details
  - Issue Type (Dropdown/Chips selection):
    Fraud, Payment Issue, Late Payment, Fake Order,
    Order Cancellation, Financial Loss, Time Loss,
    Misleading Info, Other
  - Title (short text, required)
  - Description (long text, required, min 20 chars)
  - Loss Amount (optional, number field)
  - Incident Date (optional, date picker — not future date)
  - Next button

  Step 3: Upload Evidence
  - "Add Evidence" button → file picker (image/PDF)
  - Show preview of selected files (thumbnails)
  - Max 5 files
  - Each file shows: preview + name + size + remove button
  - File size limit: 5MB each
  - Next button (evidence is optional but recommended)

  Step 4: Review & Submit
  - Summary of all entered data:
    - Customer: Name, Phone
    - Issue: Type, Title, Description
    - Amount, Date
    - Evidence: count + thumbnails
  - "Edit" button for each section → go back to that step
  - "Submit Report" button (loading state)
  - Success → Navigate to My Reports with success toast

  Progress indicator at top showing Step 1/4, 2/4, etc.
  Back button on each step to go to previous step
  ```

### Step 5.10: My Reports Screen
- [ ] Create `screens/report/my_reports_screen.dart`:
  ```
  - Filter tabs at top: All, Pending, Approved, Rejected, More Info Required
  - List of Report Cards:
    - Customer name + phone
    - Issue Type badge
    - Title
    - Status badge (colored)
    - Date
    - Evidence count icon
    - Tap → Report Detail
  - Pull-to-refresh
  - Pagination (load more)
  - Empty state per filter
  - FAB: "New Report" → /report/create
  ```

### Step 5.11: Report Detail Screen
- [ ] Create `screens/report/report_detail_screen.dart`:
  ```
  - Status badge (prominent, top)
  - Customer info card
  - Issue details card:
    - Issue Type
    - Title
    - Description
    - Amount (if provided)
    - Incident Date (if provided)
  - Evidence section:
    - Grid of evidence thumbnails
    - Tap image → Full screen view
    - PDF icon for PDF files
  - Timeline/Status history (optional)
  - If MORE_INFO_REQUIRED:
    - Admin's request message (highlighted card)
    - Response text field
    - "Send Response" button
    - Option to upload additional evidence
  - If REJECTED:
    - Rejection reason in red card
  - If APPROVED:
    - Success message in green card
  - Created date, last updated date
  ```

### Step 5.12: Flutter Report Integration Test
- [ ] Create report with new customer → success
- [ ] Create report with existing customer → success
- [ ] Upload evidence (image + PDF) → success
- [ ] My Reports list shows all reports with correct status
- [ ] Report detail shows all info
- [ ] Admin approves report (Postman) → status updates on refresh
- [ ] Admin requests more info → more info section appears
- [ ] User responds to more info → status goes back to pending
- [ ] Duplicate report → error message

### ✅ Phase 5 Verification Checklist:
- [ ] Multi-step report creation works end-to-end ✅
- [ ] Multiple evidence upload works ✅
- [ ] My Reports list with filters works ✅
- [ ] Report detail with evidence preview works ✅
- [ ] More info request/response flow works ✅
- [ ] Report status updates correctly ✅
- [ ] Customer search → Report flow connected ✅
- [ ] Evidence privacy maintained ✅
- [ ] Git commit: `"Phase 5: Reporting & evidence system complete"` ✅

---

# ═══════════════════════════════════════════
# PHASE 6: ADMIN PANEL (Web)
# ═══════════════════════════════════════════

**Goal:** Complete web admin panel with dashboard, business management, report review, evidence viewing

### 🎓 Learning:
> **Admin Panel Architecture:** Same NestJS backend APIs use hoti hain. Admin panel sirf ek alag frontend hai (React/Next.js) jo admin-only APIs call karta hai. Backend mein role-based guards ensure karte hain ki sirf ADMIN role wale users ye APIs access kar sakein.

---

### Step 6.1: Create Next.js Project
- [ ] `npx -y create-next-app@latest admin-panel --typescript --tailwind --app --src-dir --no-eslint`
- [ ] Install additional: `npm install axios react-hot-toast @heroicons/react`
- [ ] Setup API client (Axios) pointing to NestJS backend
- [ ] Admin auth context (JWT based)

### Step 6.2: Admin Login Page
- [ ] Email + Password form
- [ ] Login API call → store JWT
- [ ] Redirect to dashboard

### Step 6.3: Dashboard Page
- [ ] Stats cards:
  - Total Business Owners
  - Pending Verifications
  - Total Reports
  - Pending Reports
  - Approved Reports
  - Total Customers
- [ ] Recent activity section
- [ ] Charts (optional): Reports per month, Issue type distribution
- [ ] Backend API: `GET /api/v1/admin/dashboard`
  ```typescript
  // Service returns:
  {
    totalUsers: number,
    pendingVerifications: number,
    totalReports: number,
    pendingReports: number,
    approvedReports: number,
    rejectedReports: number,
    totalCustomers: number,
    recentReports: Report[],      // last 5
    recentBusinesses: Business[], // last 5
  }
  ```

### Step 6.4: Business Management Pages
- [ ] **Business List Page:**
  - Table: Business Name, Owner, City, Status, Date, Actions
  - Filters: Status (All, Pending, Approved, Rejected), Search
  - Pagination
  - Click row → Business Detail
- [ ] **Business Detail Page:**
  - All business information displayed
  - Owner/User info
  - Business proof image/document preview
  - Status badge
  - Action buttons:
    - "Approve" (green) → confirmation dialog → API call
    - "Reject" (red) → rejection reason dialog → API call
  - Verification history

### Step 6.5: Report Management Pages
- [ ] **Report List Page:**
  - Table: Customer, Issue Type, Reporter, Status, Date, Actions
  - Filters: Status, Issue Type, Date Range, Search
  - Pagination
  - Click row → Report Detail
- [ ] **Report Review Page:**
  - Customer info section
  - Reporter & Business info section
  - Issue details section
  - **Evidence Gallery:**
    - Image viewer with zoom
    - PDF viewer
    - Download button
    - Evidence metadata (size, type, upload date)
  - Admin action section:
    - "Approve" button → confirmation → API call
    - "Reject" button → notes field → API call
    - "Request More Info" button → request text field → API call
  - Admin notes field
  - Status timeline

### Step 6.6: User Management Page
- [ ] User list table: Name, Email, Phone, Role, Status, Date
- [ ] Search and filters
- [ ] View user details
- [ ] Deactivate/reactivate user option

### Step 6.7: Admin Panel Layout
- [ ] Sidebar navigation:
  - Dashboard
  - Businesses (with pending count badge)
  - Reports (with pending count badge)
  - Users
  - Logout
- [ ] Top bar: Admin name, notifications
- [ ] Responsive design
- [ ] Dark/Light mode toggle (optional)

### Step 6.8: Admin Panel Testing
- [ ] Login as admin
- [ ] Dashboard shows correct stats
- [ ] Business list → view → approve/reject
- [ ] Report list → view evidence → approve/reject/request info
- [ ] All status changes reflect in Flutter app
- [ ] Pagination, search, filters working

### ✅ Phase 6 Verification Checklist:
- [ ] Admin login working ✅
- [ ] Dashboard with correct stats ✅
- [ ] Business approve/reject working ✅
- [ ] Report review with evidence view working ✅
- [ ] More info request flow working ✅
- [ ] All CRUD operations working ✅
- [ ] Status changes reflect in mobile app ✅
- [ ] Git commit: `"Phase 6: Admin panel complete"` ✅

---

# ═══════════════════════════════════════════
# PHASE 7: PUSH NOTIFICATIONS (FCM)
# ═══════════════════════════════════════════

**Goal:** Real-time push notifications for all important status changes using Firebase Cloud Messaging

### 🎓 Learning:
> **FCM (Firebase Cloud Messaging):**
> 1. App install hone pe Firebase ek unique token generate karta hai (device identifier)
> 2. Ye token backend pe save hota hai (user ke saath linked)
> 3. Jab admin koi action karta hai → backend FCM API call karta hai
> 4. Google ke servers notification user ke phone pe deliver karte hain
> 5. App open ho ya band — dono cases mein notification aata hai

---

## 7A — Backend: Notification Module

### Step 7.1: FCM & Notification Schema (Prisma)
- [ ] Add to `schema.prisma`:
  ```prisma
  model FcmToken {
    id        String   @id @default(uuid())
    userId    String
    user      User     @relation(fields: [userId], references: [id], onDelete: Cascade)
    token     String   @unique
    deviceInfo String?
    isActive  Boolean  @default(true)
    createdAt DateTime @default(now())
    updatedAt DateTime @updatedAt
    
    @@index([userId])
  }

  model Notification {
    id        String   @id @default(uuid())
    userId    String
    user      User     @relation(fields: [userId], references: [id], onDelete: Cascade)
    title     String
    body      String
    type      NotificationType
    data      Json?    // Additional data (reportId, businessId, etc.)
    isRead    Boolean  @default(false)
    readAt    DateTime?
    createdAt DateTime @default(now())
    
    @@index([userId, isRead])
    @@index([createdAt])
  }

  enum NotificationType {
    BUSINESS_APPROVED
    BUSINESS_REJECTED
    REPORT_APPROVED
    REPORT_REJECTED
    REPORT_MORE_INFO
    GENERAL
  }
  ```
- [ ] Run: `npx prisma migrate dev --name add_notification_tables`

### Step 7.2: Firebase Admin SDK Setup
- [ ] Create `notifications/firebase.service.ts`:
  ```typescript
  // Initialize Firebase Admin SDK with service account credentials
  // Method: sendPushNotification(token, title, body, data?)
  // Method: sendToMultipleTokens(tokens[], title, body, data?)
  ```

### Step 7.3: Notification Service
- [ ] Create `notifications/notification.service.ts`:
  ```
  registerToken(userId, token, deviceInfo):
    1. Upsert FCM token (avoid duplicates)
    
  removeToken(token):
    1. Delete token from DB
    
  sendNotification(userId, title, body, type, data?):
    1. Create Notification record in DB
    2. Get user's FCM tokens
    3. Send push via Firebase
    4. Handle invalid tokens (remove from DB)
    
  getNotifications(userId, paginationDto):
    1. Get notifications for user
    2. Order by createdAt DESC
    3. Paginate
    
  markAsRead(notificationId, userId):
    1. Update isRead = true, readAt = now
    
  markAllAsRead(userId):
    1. Update all unread notifications for user
    
  getUnreadCount(userId):
    1. Count unread notifications
  ```

### Step 7.4: Notification API Endpoints
- [ ] Create `notifications/notifications.controller.ts`:
  ```
  POST   /api/v1/notifications/token         → registerToken()    [Protected]
  DELETE /api/v1/notifications/token/:token   → removeToken()      [Protected]
  GET    /api/v1/notifications                → getNotifications() [Protected]
  PATCH  /api/v1/notifications/:id/read       → markAsRead()       [Protected]
  PATCH  /api/v1/notifications/read-all       → markAllAsRead()    [Protected]
  GET    /api/v1/notifications/unread-count   → getUnreadCount()   [Protected]
  ```

### Step 7.5: Integrate Notifications into Business & Report Services
- [ ] Update `business.service.ts` → `verifyBusiness()`:
  ```typescript
  // After approve: sendNotification(userId, "Business Verified!", "Your business has been approved.", BUSINESS_APPROVED)
  // After reject: sendNotification(userId, "Verification Rejected", "Your business verification was rejected.", BUSINESS_REJECTED)
  ```
- [ ] Update `reports.service.ts` → `reviewReport()`:
  ```typescript
  // After approve: sendNotification(reporterId, "Report Approved", "Your report has been approved.", REPORT_APPROVED, { reportId })
  // After reject: sendNotification(reporterId, "Report Rejected", "Your report was rejected.", REPORT_REJECTED, { reportId })
  // After request info: sendNotification(reporterId, "More Info Needed", "Admin needs more information.", REPORT_MORE_INFO, { reportId })
  ```

---

## 7B — Flutter: FCM Integration

### Step 7.6: Firebase Project Setup
- [ ] Create Firebase project (if not exists)
- [ ] Add Android app to Firebase project
- [ ] Download `google-services.json` → place in `mobile/android/app/`
- [ ] Configure `android/build.gradle` and `android/app/build.gradle` for Firebase
- [ ] Initialize Firebase in `main.dart`

### Step 7.7: FCM Service
- [ ] Create `services/notification/fcm_service.dart`:
  ```dart
  // Initialize FCM
  // Request notification permission
  // Get FCM token → send to backend
  // Listen for token refresh → update backend
  // Handle foreground messages → show in-app notification
  // Handle background messages → system notification
  // Handle notification tap → navigate to relevant screen
  ```

### Step 7.8: Notification Provider
- [ ] Create `providers/notification_provider.dart`

### Step 7.9: Notifications Screen
- [ ] Create `screens/notification/notifications_screen.dart`:
  ```
  - List of all notifications
  - Each notification card: icon, title, body, time ago, read/unread indicator
  - Tap → navigate to relevant screen (report detail, business profile, etc.)
  - Swipe to mark as read
  - "Mark All as Read" button
  - Pull-to-refresh
  - Empty state: "No notifications yet"
  ```

### Step 7.10: Notification Badge
- [ ] Home screen app bar → notification icon with unread count badge
- [ ] Bottom nav → notification tab with badge

### Step 7.11: FCM Testing
- [ ] Login → FCM token saved to backend
- [ ] Admin approves business → notification received
- [ ] Admin approves/rejects report → notification received
- [ ] Admin requests more info → notification received
- [ ] Tap notification → correct screen opens
- [ ] Notification list shows all past notifications
- [ ] Mark as read works
- [ ] App in foreground: in-app notification
- [ ] App in background: system notification

### ✅ Phase 7 Verification Checklist:
- [ ] FCM token registration working ✅
- [ ] All notification types triggering correctly ✅
- [ ] Push notifications received (foreground + background) ✅
- [ ] Notification tap opens correct screen ✅
- [ ] Notification list screen working ✅
- [ ] Unread count badge working ✅
- [ ] Mark as read working ✅
- [ ] Git commit: `"Phase 7: Push notifications complete"` ✅

---

# ═══════════════════════════════════════════
# PHASE 8: POLISH, SECURITY & DEPLOYMENT
# ═══════════════════════════════════════════

**Goal:** Production-ready quality — comprehensive error handling, security hardening, UI polish, end-to-end testing, build & deployment

---

## 8A — Error Handling & Edge Cases

### Step 8.1: Backend Error Handling
- [ ] All possible error scenarios have proper HTTP status codes
- [ ] Validation errors return specific field-level messages
- [ ] Database unique constraint violations return user-friendly messages
- [ ] File upload errors handled gracefully (Cloudinary down, invalid file)
- [ ] JWT expired returns 401 (not 500)
- [ ] Rate limiting returns 429 with retry-after header
- [ ] Unhandled exceptions caught by global filter (no stack traces in production)

### Step 8.2: Flutter Error Handling
- [ ] Network errors: "No internet connection. Please check your network."
- [ ] Server errors (500): "Something went wrong. Please try again later."
- [ ] Timeout errors: "Request timed out. Please try again."
- [ ] Auth errors (401): Auto-refresh token → if fail → redirect to login
- [ ] Validation errors (400): Show field-specific errors below each field
- [ ] No crash on any error — all caught gracefully

### Step 8.3: Edge Cases
- [ ] Empty list states (no reports, no notifications, no search results)
- [ ] Loading states on every API call (shimmer/spinner)
- [ ] Pull-to-refresh on all list screens
- [ ] Prevent double-tap submit (disable button during loading)
- [ ] Handle back button correctly on all screens
- [ ] Handle app killed and reopened (restore state)
- [ ] Large text overflow handling
- [ ] Slow network simulation testing

---

## 8B — Security Hardening

### Step 8.4: Backend Security
- [ ] Rate limiting on auth endpoints (5 attempts per minute for login)
- [ ] Input sanitization (remove HTML/script tags from text inputs)
- [ ] File type validation on server side (don't trust client)
- [ ] Cloudinary signed uploads (prevent URL tampering)
- [ ] CORS properly configured (only allow specific origins)
- [ ] Helmet headers configured
- [ ] Password policy enforced (min 8, uppercase, lowercase, number)
- [ ] JWT secrets are strong (min 32 characters)
- [ ] Environment variables not committed to git
- [ ] SQL injection prevention (Prisma handles this, but verify)
- [ ] API versioning (`/api/v1/`) for future compatibility
- [ ] Request payload size limit (10MB max)

### Step 8.5: Flutter Security
- [ ] JWT tokens stored in encrypted secure storage (not SharedPreferences)
- [ ] No sensitive data in logs
- [ ] Certificate pinning (optional, advanced)
- [ ] ProGuard enabled for release build (code obfuscation)
- [ ] No hardcoded API keys in source code
- [ ] API base URL from config (not hardcoded)

---

## 8C — UI Polish

### Step 8.6: Visual Polish
- [ ] Consistent color scheme across all screens
- [ ] Consistent spacing, padding, font sizes
- [ ] Proper keyboard handling (scroll when keyboard appears)
- [ ] Status bar color matches app theme
- [ ] App icon designed and set
- [ ] Splash screen with proper branding
- [ ] Smooth screen transitions/animations
- [ ] Button press feedback (ripple, color change)
- [ ] Form focus management (next field on enter)
- [ ] Toast/Snackbar styling consistent

### Step 8.7: Responsive Design
- [ ] Test on small phones (5")
- [ ] Test on large phones (6.7")
- [ ] Test on tablets (optional)
- [ ] Text doesn't overflow on any screen
- [ ] Images scale properly
- [ ] Landscape mode handled (or locked to portrait)

---

## 8D — End-to-End Testing

### Step 8.8: Complete Flow Test
- [ ] **Flow 1: New Business Owner**
  ```
  1. Open app → Welcome screen
  2. Register → account created
  3. Business registration form → submit
  4. Verification pending screen shows
  5. Admin approves (admin panel)
  6. Notification received
  7. Refresh → Home screen with verified status
  ```
- [ ] **Flow 2: Search Customer**
  ```
  1. Verified user → Home → Search
  2. Search by name → results show
  3. Search by phone → results show
  4. Tap customer → detail shows approved reports
  5. No evidence visible
  ```
- [ ] **Flow 3: Report Customer**
  ```
  1. Verified user → New Report
  2. Enter/Search customer
  3. Select issue type, title, description
  4. Upload evidence (2-3 files)
  5. Review & Submit
  6. My Reports → new report shows (PENDING)
  7. Admin reviews evidence (admin panel)
  8. Admin approves report
  9. Notification received
  10. Report status updated to APPROVED
  11. Search customer → approved report shows in results
  ```
- [ ] **Flow 4: More Info Request**
  ```
  1. Admin requests more info on report
  2. User gets notification
  3. Report detail → more info section visible
  4. User responds with text
  5. Status back to PENDING
  6. Admin reviews again
  ```
- [ ] **Flow 5: Business Rejection**
  ```
  1. Admin rejects business with reason
  2. Notification received
  3. User sees rejection reason
  4. User can update business info and re-submit
  ```
- [ ] **Flow 6: Admin Panel**
  ```
  1. Admin login → Dashboard
  2. View pending businesses → approve one
  3. View pending reports → view evidence → approve
  4. Stats update on dashboard
  ```

---

## 8E — Build & Deployment

### Step 8.9: Flutter Release Build
- [ ] Create signing key:
  ```bash
  keytool -genkey -v -keystore ~/my-bad-customer-key.jks \
    -keyalg RSA -keysize 2048 -validity 10000 \
    -alias my-bad-customer
  ```
- [ ] Configure `android/key.properties`
- [ ] Configure `android/app/build.gradle` for release signing
- [ ] Build release APK:
  ```bash
  flutter build apk --release
  ```
- [ ] Test APK on physical device
- [ ] App size optimization (remove unused packages, enable R8)

### Step 8.10: Backend Deployment
- [ ] Choose hosting: Railway / Render / DigitalOcean / VPS
- [ ] Setup production PostgreSQL database (Railway / Supabase / Neon)
- [ ] Setup production environment variables
- [ ] Configure production CORS (admin panel domain)
- [ ] Deploy NestJS:
  ```bash
  npm run build
  # Deploy dist/ folder
  ```
- [ ] Run production migrations: `npx prisma migrate deploy`
- [ ] Seed admin user in production
- [ ] Verify all API endpoints accessible
- [ ] Setup logging (optional: Sentry for error tracking)

### Step 8.11: Admin Panel Deployment
- [ ] Deploy Next.js to Vercel:
  ```bash
  npx vercel deploy
  ```
- [ ] Configure environment variables on Vercel
- [ ] Point API URL to production backend
- [ ] Test admin panel on production

### Step 8.12: Update Flutter to Production API
- [ ] Update API base URL to production server URL
- [ ] Build new release APK with production URL
- [ ] Final testing with production backend

### ✅ Phase 8 Final Verification Checklist:
- [ ] All 6 flows tested successfully ✅
- [ ] No crashes on any error scenario ✅
- [ ] Security measures in place ✅
- [ ] UI polished and consistent ✅
- [ ] Release APK built and tested ✅
- [ ] Backend deployed and accessible ✅
- [ ] Admin panel deployed and accessible ✅
- [ ] Complete system working end-to-end ✅
- [ ] Git commit: `"Phase 8: Production ready — v1.0.0"` ✅

---

## 📊 Phase Dependency Map

```mermaid
graph TD
    P0["Phase 0: Environment Setup"] --> P1["Phase 1: Project Foundation"]
    P1 --> P2["Phase 2: Authentication"]
    P2 --> P3["Phase 3: Business & Verification"]
    P2 --> P4["Phase 4: Customer Search"]
    P3 --> P5["Phase 5: Reporting & Evidence"]
    P4 --> P5
    P5 --> P6["Phase 6: Admin Panel"]
    P6 --> P7["Phase 7: Notifications"]
    P7 --> P8["Phase 8: Polish & Deploy"]
```

---

## 🕐 Estimated Timeline

| Phase | Estimated Sessions | Cumulative |
|-------|-------------------|-----------|
| Phase 0 | 1-2 sessions | 1-2 |
| Phase 1 | 2-3 sessions | 3-5 |
| Phase 2 | 2-3 sessions | 5-8 |
| Phase 3 | 2-3 sessions | 7-11 |
| Phase 4 | 2 sessions | 9-13 |
| Phase 5 | 3-4 sessions | 12-17 |
| Phase 6 | 3-4 sessions | 15-21 |
| Phase 7 | 1-2 sessions | 16-23 |
| Phase 8 | 2-3 sessions | 18-26 |

> [!NOTE]
> "Session" = ek sitting mein jitna kaam hoga (2-4 hours typically). Total ~18-26 sessions mein poora app ready hoga.

---

> [!IMPORTANT]
> **Har phase ke end mein:**
> 1. Sab todos checked ✅
> 2. All tests pass ✅
> 3. Git commit with proper message ✅
> 4. Quick review of what we built ✅
> 5. Then move to next phase ✅
>
> **Kisi bhi phase mein bug aaye → uss phase mein hi fix karo. Next phase mein mat le jao.**
