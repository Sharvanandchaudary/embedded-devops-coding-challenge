# Cloud Environment State (CES) Management System

A comprehensive React-based application for managing and monitoring cloud environment states with auto-authentication, Excel data processing capabilities, and a REST API server with comprehensive rate limiting for external integrations.

## 📁 Project Structure

```
ces/
├── chamber-state-app/          # Main application directory
│   ├── src/                    # Frontend React application
│   │   ├── components/         # React components
│   │   ├── contexts/           # React contexts
│   │   ├── hooks/              # Custom hooks
│   │   ├── services/           # Frontend services
│   │   ├── types/              # TypeScript type definitions
│   │   └── utils/              # Utility functions
│   ├── server/                 # Backend REST API server
│   │   ├── routes/             # API route handlers
│   │   ├── services/           # Backend services
│   │   ├── server.js           # Main server file
│   │   └── package.json        # Server dependencies
│   ├── docs/                   # Project documentation
│   │   ├── API_DOCUMENTATION.md # Comprehensive API reference with authentication
│   │   ├── SECURITY_IMPROVEMENTS.md # Security vulnerabilities and fixes
│   │   ├── SETUP.md            # Quick start guide
│   │   └── ...                 # Other documentation files
│   ├── public/                 # Static assets & Excel data
│   │   └── CCChambers.xlsx     # Chamber data source
│   ├── build/                  # Production build output
│   └── README.md               # Main project documentation
└── README.md                   # This file (project overview)
```

## 🚀 Getting Started

### Quick Setup (5 minutes)
For a complete quick start guide, see: [chamber-state-app/docs/SETUP.md](./chamber-state-app/docs/SETUP.md)

### Prerequisites

- Node.js (v16 or higher)
- npm package manager

### Installation & Startup

1. **Navigate to the application directory:**
   ```bash
   cd chamber-state-app
   ```

2. **Install dependencies:**
   ```bash
   # Frontend dependencies
   npm install
   
   # Backend dependencies
   cd server
   npm install
   cd ..
   ```

3. **Start both services:**
   
   **Terminal 1 - Start API Server:**
   ```bash
   cd server
   npm start
   ```
   Server runs on `http://localhost:3001`
   
   **Terminal 2 - Start Frontend:**
   ```bash
   npm start
   ```
   Frontend opens at `http://localhost:3000`

4. **Verify setup:**
   - Frontend: Visit `http://localhost:3000` (auto-authentication - no login required)
   - API: Test with `curl http://localhost:3001/health`
   - Rate limiting: Check `curl http://localhost:3001/api/rate-limit-status`

## 🔧 Available Scripts

### Frontend (React App)
In the `chamber-state-app` directory:

- `npm start` - Runs the frontend in development mode (port 3000)
- `npm test` - Launches the test runner
- `npm run build` - Builds the frontend for production
- `npm run eject` - Ejects from Create React App (one-way operation)

### Backend (API Server)
In the `chamber-state-app/server` directory:

- `npm start` - Runs the API server (port 3001)
- `npm run dev` - Runs server with auto-reload using nodemon
- `npm test` - Runs API tests

## 🏗️ Application Features

### 🔐 Authentication System
- Auto-authentication with seamless admin access
- No login screen required - immediate application access
- Hidden admin UI elements for clean interface
- Preserved authentication logic for future use
- Session management with manual logout detection

### 📊 Data Management
- Excel file processing (CCChambers.xlsx)
- Chamber state visualization
- Real-time data updates
- Environment-specific chamber views

### 🌐 REST API Server
- **Chamber Lookups**: Find chambers by AWS or CC numbers
- **Search Functionality**: Search across all chambers with pagination
- **Rate Limiting**: Multi-tier protection (100/15min general, 30/5min search)
- **Smart Rate Limiting**: Successful requests don't count against search limits
- **Rate Limit Monitoring**: Status endpoint for tracking usage
- **External Integration**: cURL, Python, JavaScript support
- **Comprehensive Documentation**: Built-in API docs with rate limiting info

### 🎨 User Interface
- Modern, responsive design
- Intuitive navigation
- Mobile-friendly layout
- Environment-based chamber organization

## 📋 API Usage Examples

The REST API provides external access to chamber data:

```bash
# Get chamber by AWS number
curl http://localhost:3001/api/chamber/aws/PROD-001

# Get chamber by CC number
curl http://localhost:3001/api/chamber/cc/CC-PROD-001

# Search chambers
curl "http://localhost:3001/api/chambers/search?q=PROD"

# Check API rate limit status
curl http://localhost:3001/api/rate-limit-status

# API health check
curl http://localhost:3001/health
```

**API Response Format:**
```json
{
  "awsChamber": "PROD-001",
  "ccChamber": "CC-PROD-001",
  "hub": "HUB-01",
  "state": "Deployed",
  "environment": "production",
  "customer": "Customer Name",
  "type": "AWS+CC",
  "access": "Internal"
}
```

## 📖 Documentation

Comprehensive documentation is available in the `chamber-state-app` directory:

### Quick References
- **[SETUP.md](./chamber-state-app/docs/SETUP.md)** - 5-minute quick start guide
- **[README.md](./chamber-state-app/README.md)** - Complete project documentation

### API Documentation
- **[API_DOCUMENTATION.md](./chamber-state-app/docs/API_DOCUMENTATION.md)** - Comprehensive API reference with authentication and rate limiting
- **[server/README.md](./chamber-state-app/server/README.md)** - Server configuration guide
- **[RATE_LIMITING_SUMMARY.md](./chamber-state-app/server/RATE_LIMITING_SUMMARY.md)** - Rate limiting implementation details

### Security Documentation
- **[SECURITY_IMPROVEMENTS.md](./chamber-state-app/docs/SECURITY_IMPROVEMENTS.md)** - Security vulnerability fixes and mitigations

### Legacy Documentation
- [Quick Setup Guide](./chamber-state-app/docs/SETUP.md) - 5-minute quick start
- [Design Document](./chamber-state-app/docs/DESIGN_DOCUMENT.md)
- [Authentication Guide](./chamber-state-app/docs/AUTHENTICATION_GUIDE.md)
- [Testing Guide](./test/TESTING.md) - Complete testing implementation
- [Testing Status](./chamber-state-app/docs/TESTING_STATUS.md) - Current test results
- [Project Status](./chamber-state-app/docs/PROJECT_STATUS.md)
- [Chamber Overview Fixes](./chamber-state-app/docs/CHAMBER_OVERVIEW_FIXES.md)
- [Lessons Learned](./LESSONS_LEARNED.md) - Development insights and best practices

## 🛠️ Technology Stack

### Frontend
- **Framework**: React 18 + TypeScript
- **Styling**: CSS3 with custom components
- **State Management**: React Context API
- **Testing**: Jest + React Testing Library
- **Build Tool**: Create React App

### Backend
- **Runtime**: Node.js + Express.js
- **Rate Limiting**: Multi-tier protection with express-rate-limit
- **Security**: Helmet.js security headers, CORS configuration
- **Data Processing**: Custom Excel parsing (XLSX) with environment awareness
- **API Documentation**: Built-in documentation endpoints
- **Testing**: Comprehensive Jest + Supertest test suite

### Data & Integration
- **Data Source**: Excel files (CCChambers.xlsx) with sample data fallback
- **API Format**: RESTful JSON APIs with rate limiting headers
- **External Access**: cURL, Python, JavaScript, PowerShell with rate limit awareness
- **Authentication**: Auto-authentication frontend (API currently open)
- **Environment Awareness**: Test/production data loading strategies

### 🔒 Security & Quality Features

- ✅ **Input Validation**: Form validation and sanitization
- ✅ **Auto-Authentication**: Seamless access without login friction
- ✅ **Rate Limiting**: Multi-tier API protection against abuse
- ✅ **Session Management**: Persistent authentication state with logout detection
- ✅ **CSRF Protection**: Built-in security measures
- ✅ **Type Safety**: Full TypeScript implementation
- ✅ **Testing Coverage**: Comprehensive test suite (43 tests)
- ✅ **Error Handling**: Graceful error boundaries and recovery
- ✅ **Data Validation**: Excel parsing with fallback mechanisms

### 🧪 Testing ✅ COMPLETE

The application includes comprehensive testing for both frontend and backend with **all 43 tests passing**:

### Frontend Testing
```bash
cd chamber-state-app
npm test

# Run with coverage
npm test -- --coverage

# Cross-platform test execution
.\test\run-tests.ps1    # Windows PowerShell
./test/run-tests.sh     # Unix/Linux/macOS
```

### Backend Testing
```bash
cd chamber-state-app/server
npm test
```

### Test Results Summary
- ✅ **Server Tests**: 43 passing (Rate limiting, API endpoints, DataLoader, Routes)
  - Rate limiting tests: 7
  - Server integration tests: 18
  - Chamber routes tests: 12
  - DataLoader service tests: 6
- ✅ **Total Coverage**: 43/43 tests (100% success rate)
- ✅ **Cross-Platform**: PowerShell and Bash test runners
- ✅ **Rate Limiting**: Comprehensive API protection testing
- ✅ **Error Scenarios**: Authentication, validation, loading states

### Test Categories
- Rate limiting protection tests
- API endpoint testing with Supertest
- Chamber data processing validation
- DataLoader service functionality
- Server integration and health checks
- Environment-aware data loading
- Error handling and recovery scenarios

For detailed testing documentation:
- [TESTING.md](./test/TESTING.md) - Complete testing guide
- [TESTING_STATUS.md](./chamber-state-app/docs/TESTING_STATUS.md) - Implementation results

## 📦 Deployment

### Frontend Deployment
To build the React application for production:

```bash
cd chamber-state-app
npm run build
```

The `build` folder contains optimized production files ready for static hosting.

### Backend Deployment
To deploy the API server:

```bash
cd chamber-state-app/server
npm install --production
PORT=3001 NODE_ENV=production npm start
```

### Docker Deployment
See [chamber-state-app/README.md](./chamber-state-app/README.md) for Docker configuration examples.

### Environment Configuration
- **Frontend**: Configure API URLs in environment variables
- **Backend**: Set PORT, CORS_ORIGIN, and other settings in `server/.env`

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📝 License

This project is licensed under the MIT License - see the LICENSE file for details.

## 📞 Support

### Documentation & Help
- **Quick Start**: [chamber-state-app/docs/SETUP.md](./chamber-state-app/docs/SETUP.md)
- **Full Documentation**: [chamber-state-app/README.md](./chamber-state-app/README.md)
- **API Reference**: [chamber-state-app/docs/API_DOCUMENTATION.md](./chamber-state-app/docs/API_DOCUMENTATION.md) (includes authentication)

### Troubleshooting
- Check the comprehensive troubleshooting section in the main README
- Verify Excel file format and location (`public/CCChambers.xlsx`)
- Ensure both frontend and backend services are running
- Test API connectivity with health endpoint

### Common Issues & Solutions
- **Port conflicts**: Use `PORT=3002 npm start` to change ports
- **Excel file not found**: Ensure `CCChambers.xlsx` exists in `public/` directory
- **API not responding**: Verify server is running on port 3001
- **Test failures**: Run `npm test` to verify all 43 tests pass
- **Login issues**: Application uses auto-authentication (no login required)
- **Rate limiting**: Check `curl http://localhost:3001/api/rate-limit-status`
- **Data not loading**: Check browser console and refresh data using 🔄 button
- **Internal/External showing N/A**: Recent fix implemented - restart dev server

For detailed troubleshooting, see the main documentation or create an issue in the repository.

---

## 🏢 Project Architecture

```
┌─────────────────┐    HTTP/JSON    ┌─────────────────┐
│   Frontend      │ ◄─────────────► │   Backend API   │
│   React App     │                 │   Express.js    │
│   Port: 3000    │                 │   Port: 3001    │
└─────────────────┘                 └─────────────────┘
         │                                   │
         │ User Interface                    │ Data Processing
         ▼                                   ▼
┌─────────────────┐                 ┌─────────────────┐
│   Web Browser   │                 │   Excel Files   │
│   Authentication│                 │ CCChambers.xlsx │
│   Chamber Views │                 │  (Data Source)  │
└─────────────────┘                 └─────────────────┘
```

**Note**: This is the root directory of the CES project. The main application code and documentation are located in the `chamber-state-app` subdirectory.
