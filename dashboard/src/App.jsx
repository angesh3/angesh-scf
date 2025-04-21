function App() {
  return (
    <div style={{ padding: '2rem' }}>
      <header style={{ display: 'flex', alignItems: 'center', marginBottom: '2rem' }}>
        <img 
          src="/scf-logo.svg" 
          alt="SCF Logo" 
          style={{ width: '80px', height: '80px', marginRight: '1rem' }}
        />
        <h1>Security Compliance Framework</h1>
      </header>
      <main>
        <p>Dashboard is running successfully!</p>
        <p>Compliance scanning and reporting dashboard for your cloud infrastructure.</p>
      </main>
    </div>
  )
}

export default App
