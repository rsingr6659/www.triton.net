$favicon  = Get-Content 'C:/Users/admin/Desktop/websitefull/tmp_favicon.txt'  -Raw
$navLogo  = Get-Content 'C:/Users/admin/Desktop/websitefull/tmp_navlogo.txt'  -Raw
$footLogo = Get-Content 'C:/Users/admin/Desktop/websitefull/tmp_footlogo.txt' -Raw

$html = @"
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Business VoIP Phone System (TTI-VoIP) — Triton Technologies, Inc.</title>
<link rel="icon" type="image/png" href="$favicon"/>
<link href="https://fonts.googleapis.com/css2?family=Raleway:wght@700;800;900&display=swap" rel="stylesheet"/>
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&family=JetBrains+Mono:wght@400;500&display=swap" rel="stylesheet">
<style>
*,*::before,*::after{box-sizing:border-box;margin:0;padding:0;}
html{scroll-behavior:smooth;}
:root{
  --teal:#007B7F; --teal-dk:#005457; --teal-dp:#003638; --teal-lt:#EEF7F7;
  --yellow:#D4A800; --yellow-lt:#fffbeb;
  --navy:#005457; --navy-dk:#003638; --navy-md:#007B7F; --navy-lt:#EEF7F7;
  --white:#ffffff; --off:#F5FAFA; --dark:#1A1A1A; --mid:#454545; --muted:#7A8A8A;
  --rule:#C8D8D8; --rule-lt:#E0EEEE;
  --sh:0 1px 8px rgba(0,54,56,.08); --sh-md:0 4px 20px rgba(0,54,56,.12);
  --sh-lg:0 12px 40px rgba(0,54,56,.16); --sh-xl:0 24px 64px rgba(0,0,0,.18);
  --r:8px; --r-lg:14px;
  --font:'Inter',sans-serif; --mono:'JetBrains Mono',monospace;
}
body{font-family:var(--font);color:var(--dark);background:var(--white);overflow-x:hidden;line-height:1.6;}

/* NAV */
nav{position:fixed;top:0;left:0;right:0;z-index:1000;background:var(--white);border-bottom:1px solid var(--rule);box-shadow:var(--sh);height:64px;}
.nav-inner{max-width:1200px;margin:0 auto;height:100%;padding:0 32px;display:flex;align-items:center;justify-content:space-between;}
.nav-logo{display:flex;align-items:center;cursor:pointer;text-decoration:none;}
.nav-logo img{height:38px;display:block;}
.nav-links{display:flex;align-items:center;gap:2px;}
.nl{font-size:13px;font-weight:500;color:var(--mid);padding:6px 14px;border-radius:6px;cursor:pointer;transition:color .13s,background .13s;border:none;background:none;font-family:var(--font);letter-spacing:-.01em;text-decoration:none;display:inline-block;}
.nl:hover{color:var(--navy);background:var(--navy-lt);}
.nl.active{color:var(--navy);font-weight:600;}
.nav-cta{margin-left:8px;background:var(--navy);color:var(--white);font-size:13px;font-weight:600;padding:8px 18px;border-radius:7px;cursor:pointer;border:none;display:inline-flex;align-items:center;gap:7px;transition:background .13s,transform .13s;font-family:var(--font);text-decoration:none;}
.nav-cta:hover{background:var(--navy-dk);transform:translateY(-1px);}

/* HERO */
.hero{padding:128px 0 80px;background:linear-gradient(160deg,var(--navy-dk) 0%,var(--navy) 55%,var(--teal) 100%);position:relative;overflow:hidden;}
.hero::after{content:'';position:absolute;inset:0;pointer-events:none;background:radial-gradient(ellipse 60% 80% at 65% 60%,rgba(212,168,0,.07) 0%,transparent 60%),radial-gradient(ellipse 40% 60% at 20% 30%,rgba(255,255,255,.03) 0%,transparent 50%);}
.hero-inner{max-width:1200px;margin:0 auto;padding:0 32px;display:grid;grid-template-columns:1fr 420px;gap:80px;align-items:center;position:relative;z-index:1;}
.hero-kicker{font-size:11px;font-weight:700;letter-spacing:.18em;text-transform:uppercase;color:rgba(255,255,255,.45);margin-bottom:16px;}
.hero h1{font-size:clamp(34px,4.5vw,54px);font-weight:800;color:var(--white);line-height:1.08;margin-bottom:18px;letter-spacing:-.03em;}
.hero h1 strong{color:var(--yellow);font-weight:800;}
.hero-sub{font-size:16px;color:rgba(255,255,255,.75);line-height:1.75;margin-bottom:40px;max-width:460px;}
.hero-btns{display:flex;gap:12px;flex-wrap:wrap;margin-bottom:52px;}
.btn-primary{background:var(--yellow);color:var(--navy-dk);font-size:14px;font-weight:700;padding:12px 24px;border-radius:8px;cursor:pointer;border:none;transition:all .14s;display:inline-flex;align-items:center;gap:8px;font-family:var(--font);text-decoration:none;}
.btn-primary:hover{background:#e6bb00;transform:translateY(-2px);box-shadow:0 8px 24px rgba(245,200,0,.3);}
.btn-outline{background:transparent;color:rgba(255,255,255,.85);font-size:14px;font-weight:500;padding:12px 24px;border-radius:8px;cursor:pointer;border:1.5px solid rgba(255,255,255,.25);transition:all .14s;font-family:var(--font);display:inline-flex;align-items:center;gap:8px;text-decoration:none;}
.btn-outline:hover{background:rgba(255,255,255,.07);border-color:rgba(255,255,255,.4);}
.hero-stats{display:flex;gap:36px;flex-wrap:wrap;}
.hero-stat .n{font-size:28px;font-weight:800;color:var(--yellow);letter-spacing:-.02em;}
.hero-stat .l{font-size:12px;color:rgba(255,255,255,.5);margin-top:2px;line-height:1.4;}

/* PBX DIAGRAM */
.pbx-diagram{background:rgba(0,0,0,.35);border-radius:16px;padding:28px;border:1px solid rgba(255,255,255,.1);backdrop-filter:blur(6px);}
.pbx-title{font-size:10px;font-weight:700;letter-spacing:.14em;text-transform:uppercase;color:rgba(255,255,255,.35);text-align:center;margin-bottom:20px;}
.pbx-core{display:flex;align-items:center;justify-content:center;margin-bottom:20px;}
.pbx-box{background:linear-gradient(135deg,var(--teal-dk),var(--navy-dk));border:1.5px solid var(--yellow);border-radius:10px;padding:14px 20px;text-align:center;}
.pbx-box .pbx-icon{font-size:28px;margin-bottom:6px;}
.pbx-box .pbx-label{font-size:11px;font-weight:700;color:var(--yellow);letter-spacing:.06em;}
.pbx-box .pbx-sub{font-size:9px;color:rgba(255,255,255,.5);margin-top:2px;}
.pbx-endpoints{display:grid;grid-template-columns:repeat(3,1fr);gap:10px;}
.pbx-ep{background:rgba(255,255,255,.05);border:1px solid rgba(255,255,255,.1);border-radius:8px;padding:10px 8px;text-align:center;}
.pbx-ep .ep-icon{font-size:20px;margin-bottom:4px;}
.pbx-ep .ep-label{font-size:10px;color:rgba(255,255,255,.6);font-weight:500;}
.pbx-ep .ep-detail{font-size:9px;color:rgba(255,255,255,.3);margin-top:2px;}
.pbx-connector{width:2px;height:18px;background:linear-gradient(to bottom,var(--yellow),rgba(212,168,0,.2));margin:0 auto 8px;}

/* SECTION COMMON */
.section{padding:80px 0;}
.section-inner{max-width:1200px;margin:0 auto;padding:0 32px;}
.sec-kicker{font-size:11px;font-weight:700;letter-spacing:.16em;text-transform:uppercase;color:var(--teal);margin-bottom:10px;}
.sec-title{font-size:clamp(26px,3.5vw,38px);font-weight:800;color:var(--navy-dk);letter-spacing:-.02em;line-height:1.15;margin-bottom:14px;}
.sec-title.lt{color:var(--white);}
.sec-desc{font-size:15px;color:var(--muted);line-height:1.75;max-width:560px;}
.sec-desc.lt{color:rgba(255,255,255,.65);}
.section-head{margin-bottom:52px;}

/* BENEFIT CARDS */
.benefit-grid{display:grid;grid-template-columns:repeat(3,1fr);gap:24px;}
.benefit-card{background:var(--white);border:1px solid var(--rule);border-radius:var(--r-lg);padding:32px 28px;box-shadow:var(--sh);transition:transform .2s,box-shadow .2s;}
.benefit-card:hover{transform:translateY(-5px);box-shadow:var(--sh-lg);}
.benefit-icon{width:52px;height:52px;border-radius:12px;background:var(--navy-lt);display:flex;align-items:center;justify-content:center;font-size:24px;margin-bottom:20px;}
.benefit-card h3{font-size:17px;font-weight:800;color:var(--navy-dk);margin-bottom:10px;}
.benefit-card p{font-size:14px;color:var(--muted);line-height:1.75;}

/* FEATURES */
.section.alt{background:var(--off);}
.features-grid{display:grid;grid-template-columns:repeat(2,1fr);gap:20px;}
.feature-item{background:var(--white);border:1px solid var(--rule);border-radius:var(--r-lg);padding:28px 24px;display:flex;gap:18px;align-items:flex-start;transition:box-shadow .2s;}
.feature-item:hover{box-shadow:var(--sh-md);}
.fi-icon{width:44px;height:44px;border-radius:10px;background:var(--navy-lt);display:flex;align-items:center;justify-content:center;font-size:20px;flex-shrink:0;}
.fi-body h4{font-size:15px;font-weight:700;color:var(--navy-dk);margin-bottom:6px;}
.fi-body p{font-size:13.5px;color:var(--muted);line-height:1.7;}

/* COMPATIBLE PHONES */
.phones-grid{display:grid;grid-template-columns:repeat(4,1fr);gap:16px;margin-top:40px;}
.phone-card{background:var(--white);border:1px solid var(--rule);border-radius:var(--r);padding:20px 16px;text-align:center;box-shadow:var(--sh);}
.phone-card .ph-icon{font-size:32px;margin-bottom:10px;}
.phone-card h4{font-size:13px;font-weight:700;color:var(--navy-dk);margin-bottom:4px;}
.phone-card p{font-size:12px;color:var(--muted);}

/* MOBILE APP BANNER */
.app-banner{background:linear-gradient(135deg,var(--navy-dk),var(--teal));border-radius:var(--r-lg);padding:48px;display:grid;grid-template-columns:1fr auto;gap:40px;align-items:center;margin-top:60px;}
.app-banner h3{font-size:24px;font-weight:800;color:var(--white);margin-bottom:10px;}
.app-banner p{font-size:15px;color:rgba(255,255,255,.7);line-height:1.7;max-width:520px;}
.app-price{background:rgba(255,255,255,.1);border:1.5px solid var(--yellow);border-radius:var(--r-lg);padding:24px 32px;text-align:center;flex-shrink:0;}
.app-price .price-amt{font-size:36px;font-weight:800;color:var(--yellow);}
.app-price .price-period{font-size:12px;color:rgba(255,255,255,.5);margin-top:2px;}
.app-price .price-label{font-size:13px;color:rgba(255,255,255,.7);margin-top:6px;}

/* SPECS */
.specs-grid{display:grid;grid-template-columns:repeat(2,1fr);gap:32px;}
.spec-group h4{font-size:12px;font-weight:700;letter-spacing:.12em;text-transform:uppercase;color:var(--teal);margin-bottom:16px;padding-bottom:8px;border-bottom:2px solid var(--rule);}
.spec-row{display:flex;justify-content:space-between;padding:10px 0;border-bottom:1px solid var(--rule-lt);font-size:14px;}
.spec-row .sk{color:var(--muted);}
.spec-row .sv{color:var(--navy-dk);font-weight:600;text-align:right;}

/* QUOTE */
.section.dark{background:linear-gradient(160deg,var(--navy-dk),var(--teal-dk));}
.quote-wrap{display:grid;grid-template-columns:1fr 520px;gap:48px;align-items:start;margin-top:48px;}
.quote-intro p{font-size:15px;color:rgba(255,255,255,.65);line-height:1.75;margin-bottom:24px;}
.q-bullets{display:flex;flex-direction:column;gap:14px;}
.q-bullet{display:flex;align-items:flex-start;gap:12px;}
.q-bullet-dot{width:8px;height:8px;border-radius:50%;background:var(--yellow);flex-shrink:0;margin-top:6px;}
.q-bullet-text h4{font-size:14px;font-weight:700;color:var(--white);}
.q-bullet-text p{font-size:13px;color:rgba(255,255,255,.5);margin-top:2px;}
.quote-form{background:var(--white);border-radius:var(--r-lg);box-shadow:var(--sh-xl);padding:36px;border:1px solid var(--rule);}
.quote-form h3{font-size:18px;font-weight:800;color:var(--navy-dk);margin-bottom:4px;letter-spacing:-.01em;}
.quote-form .form-sub{font-size:13px;color:var(--muted);margin-bottom:24px;}
.form-divider{font-size:11px;font-weight:700;letter-spacing:.1em;text-transform:uppercase;color:var(--teal);padding:14px 0 8px;border-bottom:1px solid var(--rule);margin-bottom:14px;}
.form-row{display:grid;grid-template-columns:1fr 1fr;gap:14px;margin-bottom:14px;}
.form-row.single{grid-template-columns:1fr;}
.fld{display:flex;flex-direction:column;gap:5px;min-width:0;}
.fld label{font-size:12px;font-weight:600;color:var(--mid);}
.fld input,.fld select,.fld textarea{width:100%;box-sizing:border-box;font-family:var(--font);font-size:13px;color:var(--dark);background:var(--off);border:1.5px solid var(--rule);border-radius:7px;padding:9px 12px;outline:none;transition:border .13s,background .13s;}
.fld input:focus,.fld select:focus,.fld textarea:focus{border-color:var(--teal);background:var(--white);}
.fld textarea{resize:vertical;min-height:80px;}
.radio-group{display:flex;gap:10px;flex-wrap:wrap;padding-top:4px;}
.radio-opt{display:flex;align-items:center;gap:6px;font-size:13px;color:var(--mid);cursor:pointer;}
.radio-opt input{accent-color:var(--teal);width:14px;height:14px;}
.submit-btn{width:100%;background:var(--navy);color:var(--white);font-size:14px;font-weight:700;padding:13px;border-radius:8px;border:none;cursor:pointer;font-family:var(--font);transition:background .13s,transform .13s;margin-top:6px;display:flex;align-items:center;justify-content:center;gap:8px;}
.submit-btn:hover{background:var(--navy-dk);transform:translateY(-1px);}
.submit-btn:disabled{opacity:.6;cursor:not-allowed;transform:none;}
.form-success{display:none;text-align:center;padding:32px 16px;}
.form-success .fs-icon{font-size:48px;margin-bottom:16px;}
.form-success h4{font-size:18px;font-weight:800;color:var(--navy-dk);margin-bottom:8px;}
.form-success p{font-size:14px;color:var(--muted);line-height:1.7;}

/* TOAST */
.toast{position:fixed;top:50%;left:50%;transform:translate(-50%,-50%) scale(.92);background:var(--navy-dk);color:var(--white);padding:18px 32px;border-radius:12px;font-size:15px;font-weight:600;display:flex;align-items:center;gap:12px;z-index:9999;opacity:0;pointer-events:none;transition:opacity .25s,transform .25s;box-shadow:0 20px 60px rgba(0,0,0,.4);}
.toast.show{opacity:1;transform:translate(-50%,-50%) scale(1);}
.toast-icon{font-size:22px;}

/* FOOTER */
footer{background:var(--navy-dk);padding:40px 0;}
.foot-inner{max-width:1200px;margin:0 auto;padding:0 32px;display:flex;align-items:center;justify-content:space-between;gap:24px;flex-wrap:wrap;}
.foot-logo img{height:32px;filter:brightness(0) invert(1);opacity:.6;}
.foot-links{display:flex;gap:20px;flex-wrap:wrap;}
.foot-links a{font-size:12.5px;color:rgba(255,255,255,.4);text-decoration:none;transition:color .13s;}
.foot-links a:hover{color:rgba(255,255,255,.75);}
.foot-copy{font-size:12px;color:rgba(255,255,255,.25);}

/* ANCHOR OFFSET */
.anchor{display:block;height:80px;margin-top:-80px;visibility:hidden;}

/* RESPONSIVE */
@media(max-width:900px){
  .hero-inner,.quote-wrap{grid-template-columns:1fr;}
  .pbx-diagram{display:none;}
  .benefit-grid,.features-grid,.phones-grid{grid-template-columns:1fr 1fr;}
  .specs-grid{grid-template-columns:1fr;}
  .app-banner{grid-template-columns:1fr;}
}
@media(max-width:600px){
  .benefit-grid,.features-grid,.phones-grid{grid-template-columns:1fr;}
  .form-row{grid-template-columns:1fr;}
}
</style>
</head>
<body>

<!-- NAV -->
<nav>
  <div class="nav-inner">
    <a class="nav-logo" href="index.html">
      <img src="$navLogo" alt="Triton Technologies, Inc.">
    </a>
    <div class="nav-links">
      <a class="nl" href="index.html">Home</a>
      <a class="nl active" href="#features">Features</a>
      <a class="nl" href="#phones">Phones</a>
      <a class="nl" href="#specs">Specs</a>
      <a class="nl" href="#quote">Quote</a>
    </div>
    <a class="nav-cta" href="#quote">
      <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5"><path d="M21 15a2 2 0 0 1-2 2H7l-4 4V5a2 2 0 0 1 2-2h14a2 2 0 0 1 2 2z"/></svg>
      Get a Quote
    </a>
  </div>
</nav>

<!-- HERO -->
<section class="hero">
  <div class="hero-inner">
    <div>
      <p class="hero-kicker">Triton Technologies — Business VoIP</p>
      <h1>Enterprise Phone System.<br><strong>Without the Enterprise Price.</strong></h1>
      <p class="hero-sub">Built on Sangoma FreePBX — the world's most deployed open-source PBX platform. Flexible, reliable, and surprisingly affordable for businesses of any size.</p>
      <div class="hero-btns">
        <a class="btn-primary" href="#quote">Get a Quote ›</a>
        <a class="btn-outline" href="#features">See Features</a>
      </div>
      <div class="hero-stats">
        <div class="hero-stat"><div class="n">220+</div><div class="l">Countries &<br>Territories</div></div>
        <div class="hero-stat"><div class="n">1M+</div><div class="l">Active PBX<br>Deployments</div></div>
        <div class="hero-stat"><div class="n">$0</div><div class="l">Per-seat<br>License Fee</div></div>
      </div>
    </div>
    <div class="pbx-diagram">
      <div class="pbx-title">TTI VoIP System Topology</div>
      <div class="pbx-core">
        <div class="pbx-box">
          <div class="pbx-icon">☎</div>
          <div class="pbx-label">FreePBX Core</div>
          <div class="pbx-sub">Sangoma Platform</div>
        </div>
      </div>
      <div class="pbx-connector"></div>
      <div class="pbx-endpoints">
        <div class="pbx-ep"><div class="ep-icon">🖥</div><div class="ep-label">Desk Phones</div><div class="ep-detail">IP / SIP</div></div>
        <div class="pbx-ep"><div class="ep-icon">💻</div><div class="ep-label">Softphones</div><div class="ep-detail">PC / Mac</div></div>
        <div class="pbx-ep"><div class="ep-icon">📱</div><div class="ep-label">Mobile App</div><div class="ep-detail">+`$`20/yr</div></div>
        <div class="pbx-ep"><div class="ep-icon">📞</div><div class="ep-label">Conference</div><div class="ep-detail">Multi-party</div></div>
        <div class="pbx-ep"><div class="ep-icon">🤖</div><div class="ep-label">IVR / Auto</div><div class="ep-detail">Attendant</div></div>
        <div class="pbx-ep"><div class="ep-icon">🔀</div><div class="ep-label">Call Routing</div><div class="ep-detail">Groups & Queues</div></div>
      </div>
    </div>
  </div>
</section>

<!-- BENEFITS -->
<section class="section">
  <div class="section-inner">
    <div class="section-head">
      <p class="sec-kicker">Why TTI VoIP</p>
      <h2 class="sec-title">Flexible. Affordable. Reliable.</h2>
      <p class="sec-desc">Triton deploys and manages your FreePBX system on proven infrastructure — so you get enterprise-grade telephony without the enterprise-grade bill.</p>
    </div>
    <div class="benefit-grid">
      <div class="benefit-card">
        <div class="benefit-icon">⚡</div>
        <h3>Maximum Flexibility</h3>
        <p>No restrictions on extensions, users, IVRs, or ring groups. Scale from 2 phones to 200 without changing plans or paying per-seat fees. Works on-premises, in the cloud, or hybrid.</p>
      </div>
      <div class="benefit-card">
        <div class="benefit-icon">💰</div>
        <h3>Low Total Cost</h3>
        <p>FreePBX is open-source with zero per-seat licensing. You pay for hardware, setup, and ongoing support — not per-user subscriptions. Most clients save 40–70% versus hosted VoIP services.</p>
      </div>
      <div class="benefit-card">
        <div class="benefit-icon">🛡</div>
        <h3>High Reliability</h3>
        <p>Deployed on Sangoma's hardened platform, trusted in over 1 million active systems across 220+ countries. Triton monitors your system 24/7 and handles updates so you never miss a call.</p>
      </div>
    </div>
  </div>
</section>

<!-- FEATURES -->
<span class="anchor" id="features"></span>
<section class="section alt">
  <div class="section-inner">
    <div class="section-head">
      <p class="sec-kicker">Business Features</p>
      <h2 class="sec-title">Everything Your Business Needs</h2>
      <p class="sec-desc">All the features of a full enterprise PBX — included at no extra charge.</p>
    </div>
    <div class="features-grid">
      <div class="feature-item">
        <div class="fi-icon">🤖</div>
        <div class="fi-body">
          <h4>IVR with Professional Voice Prompts</h4>
          <p>Build multi-level auto-attendants that greet callers and route them by department, time of day, or menu selection. Triton can source professional voice talent for your prompts, or use built-in text-to-speech.</p>
        </div>
      </div>
      <div class="feature-item">
        <div class="fi-icon">🔔</div>
        <div class="fi-body">
          <h4>Group & Selective Ringing</h4>
          <p>Ring all phones in a department simultaneously, or route to the first available agent. Sequential, round-robin, and hunt-group strategies let you match call flow to how your team actually works.</p>
        </div>
      </div>
      <div class="feature-item">
        <div class="fi-icon">⏸</div>
        <div class="fi-body">
          <h4>Call Hold with Music on Hold</h4>
          <p>Place callers on hold with custom music or messaging. Upload your own audio or use the built-in library. Separate hold music can be set per department or time-of-day.</p>
        </div>
      </div>
      <div class="feature-item">
        <div class="fi-icon">👥</div>
        <div class="fi-body">
          <h4>Conference Calling</h4>
          <p>Dedicated conference rooms support multi-party calls with PIN-based access control. Internal and external callers can join the same conference. No per-minute fees — it runs on your system.</p>
        </div>
      </div>
      <div class="feature-item">
        <div class="fi-icon">↗</div>
        <div class="fi-body">
          <h4>Call Forwarding & Find Me</h4>
          <p>Forward calls to any number — internal extension, cell phone, or external line. "Find Me / Follow Me" rings your desk first, then your cell, ensuring you never miss an important call.</p>
        </div>
      </div>
      <div class="feature-item">
        <div class="fi-icon">📬</div>
        <div class="fi-body">
          <h4>Voicemail to Email</h4>
          <p>Voicemail messages are transcribed and delivered to your inbox as audio attachments. Review messages from anywhere without logging into the system.</p>
        </div>
      </div>
      <div class="feature-item">
        <div class="fi-icon">🕐</div>
        <div class="fi-body">
          <h4>Time Conditions & Call Flow</h4>
          <p>Define business hours, holidays, and after-hours schedules. Calls route differently on weekends, after 5pm, or during closures — automatically, without manual intervention.</p>
        </div>
      </div>
      <div class="feature-item">
        <div class="fi-icon">🎙</div>
        <div class="fi-body">
          <h4>Call Recording</h4>
          <p>Record inbound, outbound, or internal calls by extension, trunk, or queue. Recordings are stored locally and accessible through the FreePBX web portal for compliance and training.</p>
        </div>
      </div>
    </div>
  </div>
</section>

<!-- COMPATIBLE PHONES -->
<span class="anchor" id="phones"></span>
<section class="section">
  <div class="section-inner">
    <div class="section-head">
      <p class="sec-kicker">Hardware Compatibility</p>
      <h2 class="sec-title">Works with Most IP Phones</h2>
      <p class="sec-desc">FreePBX uses open SIP standards — compatible with virtually any IP phone on the market. Keep your existing hardware or let Triton source the right phones for your needs.</p>
    </div>
    <div class="phones-grid">
      <div class="phone-card"><div class="ph-icon">📞</div><h4>Grandstream</h4><p>GXP / GRP series</p></div>
      <div class="phone-card"><div class="ph-icon">📞</div><h4>Yealink</h4><p>T-Series / CP series</p></div>
      <div class="phone-card"><div class="ph-icon">📞</div><h4>Sangoma</h4><p>S / P series phones</p></div>
      <div class="phone-card"><div class="ph-icon">📞</div><h4>Polycom</h4><p>VVX / Trio series</p></div>
      <div class="phone-card"><div class="ph-icon">📞</div><h4>Cisco</h4><p>SPA / 7800 / 8800</p></div>
      <div class="phone-card"><div class="ph-icon">📞</div><h4>Snom</h4><p>D / M series</p></div>
      <div class="phone-card"><div class="ph-icon">📞</div><h4>Panasonic</h4><p>KX-TGP series</p></div>
      <div class="phone-card"><div class="ph-icon">💻</div><h4>Softphones</h4><p>Any SIP softphone</p></div>
    </div>

    <!-- MOBILE APP BANNER -->
    <div class="app-banner">
      <div>
        <h3>📱 Add Your Cell Phone to the System</h3>
        <p>The Sangoma mobile app extends your business phone system to iOS and Android devices. Make and receive calls using your office extension from anywhere — your business number shows on outbound calls, not your personal cell.</p>
        <ul style="margin-top:14px;padding-left:18px;color:rgba(255,255,255,.6);font-size:14px;line-height:2;">
          <li>Full extension features on your mobile device</li>
          <li>Transfers, holds, and conference calls from your phone</li>
          <li>Works over WiFi or cellular data</li>
          <li>Available for iOS and Android</li>
        </ul>
      </div>
      <div class="app-price">
        <div class="price-amt">`$`20</div>
        <div class="price-period">per user / year</div>
        <div class="price-label">Mobile App License</div>
      </div>
    </div>
  </div>
</section>

<!-- SPECS -->
<span class="anchor" id="specs"></span>
<section class="section alt">
  <div class="section-inner">
    <div class="section-head">
      <p class="sec-kicker">Technical Specifications</p>
      <h2 class="sec-title">Built on a Proven Platform</h2>
      <p class="sec-desc">FreePBX powers over one million active phone systems worldwide. Triton deploys on AlmaLinux with commercial-grade hardware for maximum uptime.</p>
    </div>
    <div class="specs-grid">
      <div class="spec-group">
        <h4>Platform</h4>
        <div class="spec-row"><span class="sk">PBX Software</span><span class="sv">Sangoma FreePBX 17</span></div>
        <div class="spec-row"><span class="sk">Telephony Engine</span><span class="sv">Asterisk (PJSIP)</span></div>
        <div class="spec-row"><span class="sk">Operating System</span><span class="sv">AlmaLinux / Debian 12</span></div>
        <div class="spec-row"><span class="sk">Protocol</span><span class="sv">SIP / PJSIP / IAX2</span></div>
        <div class="spec-row"><span class="sk">Deployment</span><span class="sv">On-premises or Cloud</span></div>
        <div class="spec-row"><span class="sk">Web Interface</span><span class="sv">FreePBX Admin GUI</span></div>
      </div>
      <div class="spec-group">
        <h4>Capacity (No Hard Limits)</h4>
        <div class="spec-row"><span class="sk">Extensions / Users</span><span class="sv">Unlimited</span></div>
        <div class="spec-row"><span class="sk">IVR Menus</span><span class="sv">Unlimited</span></div>
        <div class="spec-row"><span class="sk">Ring Groups</span><span class="sv">Unlimited</span></div>
        <div class="spec-row"><span class="sk">Conference Rooms</span><span class="sv">Unlimited</span></div>
        <div class="spec-row"><span class="sk">Concurrent Calls</span><span class="sv">Hardware dependent</span></div>
        <div class="spec-row"><span class="sk">Voicemail Boxes</span><span class="sv">Unlimited</span></div>
      </div>
      <div class="spec-group">
        <h4>Features Included</h4>
        <div class="spec-row"><span class="sk">IVR / Auto-Attendant</span><span class="sv">✓ Included</span></div>
        <div class="spec-row"><span class="sk">Call Recording</span><span class="sv">✓ Included</span></div>
        <div class="spec-row"><span class="sk">Voicemail to Email</span><span class="sv">✓ Included</span></div>
        <div class="spec-row"><span class="sk">Time Conditions</span><span class="sv">✓ Included</span></div>
        <div class="spec-row"><span class="sk">Call Parking</span><span class="sv">✓ Included</span></div>
        <div class="spec-row"><span class="sk">Mobile App</span><span class="sv">`$`20 / user / year</span></div>
      </div>
      <div class="spec-group">
        <h4>Triton Support</h4>
        <div class="spec-row"><span class="sk">Installation</span><span class="sv">Triton-managed</span></div>
        <div class="spec-row"><span class="sk">System Updates</span><span class="sv">Triton-managed</span></div>
        <div class="spec-row"><span class="sk">Phone Provisioning</span><span class="sv">Remote auto-config</span></div>
        <div class="spec-row"><span class="sk">Monitoring</span><span class="sv">24 / 7</span></div>
        <div class="spec-row"><span class="sk">Voice Prompts</span><span class="sv">Professional recording available</span></div>
        <div class="spec-row"><span class="sk">Training</span><span class="sv">Included at installation</span></div>
      </div>
    </div>
  </div>
</section>

<!-- QUOTE FORM -->
<span class="anchor" id="quote"></span>
<section class="section dark">
  <div class="section-inner">
    <div class="section-head">
      <p class="sec-kicker" style="color:var(--yellow);">Get Started</p>
      <h2 class="sec-title lt">Request a Quote</h2>
      <p class="sec-desc lt">Tell us about your business and we'll put together a custom VoIP solution quote — usually within one business day.</p>
    </div>
    <div class="quote-wrap">
      <div class="quote-intro">
        <div class="q-bullets">
          <div class="q-bullet"><div class="q-bullet-dot"></div><div class="q-bullet-text"><h4>Fast Turnaround</h4><p>Most quotes delivered within one business day.</p></div></div>
          <div class="q-bullet"><div class="q-bullet-dot"></div><div class="q-bullet-text"><h4>No Obligation</h4><p>Free quote, no commitment required.</p></div></div>
          <div class="q-bullet"><div class="q-bullet-dot"></div><div class="q-bullet-text"><h4>Keep Your Numbers</h4><p>We handle number porting from your current provider.</p></div></div>
          <div class="q-bullet"><div class="q-bullet-dot"></div><div class="q-bullet-text"><h4>Keep Your Phones</h4><p>We check compatibility with your existing hardware first.</p></div></div>
          <div class="q-bullet"><div class="q-bullet-dot"></div><div class="q-bullet-text"><h4>Full Installation</h4><p>Triton handles setup, provisioning, and training on-site.</p></div></div>
        </div>
      </div>
      <div class="quote-form" id="quoteFormWrap">
        <div id="quoteFormInner">
          <h3>VoIP Quote Request</h3>
          <p class="form-sub">Fill out the form and we'll be in touch shortly.</p>
          <div class="form-divider">Contact Information</div>
          <div class="form-row">
            <div class="fld"><label>Contact Name *</label><input type="text" id="f-name" placeholder="Jane Smith" required/></div>
            <div class="fld"><label>Company</label><input type="text" id="f-company" placeholder="Acme Corp"/></div>
          </div>
          <div class="form-row">
            <div class="fld"><label>Phone *</label><input type="tel" id="f-phone" placeholder="(616) 555-0100" required/></div>
            <div class="fld"><label>Email *</label><input type="email" id="f-email" placeholder="jane@example.com" required/></div>
          </div>
          <div class="form-divider">Phone System Details</div>
          <div class="form-row">
            <div class="fld"><label>Number of Extensions</label>
              <select id="f-extensions">
                <option value="">— Select —</option>
                <option>1–5</option><option>6–15</option><option>16–30</option>
                <option>31–50</option><option>51–100</option><option>100+</option>
              </select>
            </div>
            <div class="fld"><label>Mobile App Users</label>
              <select id="f-mobile">
                <option value="">— Select —</option>
                <option>None</option><option>1–5</option><option>6–15</option>
                <option>16–30</option><option>30+</option>
              </select>
            </div>
          </div>
          <div class="form-row single">
            <div class="fld"><label>Existing phone system?</label>
              <div class="radio-group">
                <label class="radio-opt"><input type="radio" name="has-system" value="yes"/> Yes, replacing existing</label>
                <label class="radio-opt"><input type="radio" name="has-system" value="no" checked/> No, new installation</label>
              </div>
            </div>
          </div>
          <div class="form-row single">
            <div class="fld"><label>Current Provider / System</label><input type="text" id="f-current" placeholder="e.g. RingCentral, old Nortel PBX"/></div>
          </div>
          <div class="form-divider">Timeline &amp; Contact</div>
          <div class="form-row single">
            <div class="fld"><label>Target Timeframe</label>
              <div class="radio-group">
                <label class="radio-opt"><input type="radio" name="timeframe" value="now"/> Ready now</label>
                <label class="radio-opt"><input type="radio" name="timeframe" value="1mo"/> Within 1 month</label>
                <label class="radio-opt"><input type="radio" name="timeframe" value="6mo"/> Within 6 months</label>
                <label class="radio-opt"><input type="radio" name="timeframe" value="undecided"/> Still deciding</label>
              </div>
            </div>
          </div>
          <div class="form-row single">
            <div class="fld"><label>Best time to contact you</label>
              <select id="f-contact-time">
                <option value="">— Select —</option>
                <option>Morning (8am–12pm)</option>
                <option>Afternoon (12pm–5pm)</option>
                <option>Anytime</option>
              </select>
            </div>
          </div>
          <div class="form-row single">
            <div class="fld"><label>Additional notes</label><textarea id="f-notes" placeholder="Special requirements, features you need, questions..."></textarea></div>
          </div>
          <button class="submit-btn" onclick="submitQuote()">
            <svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5"><line x1="22" y1="2" x2="11" y2="13"/><polygon points="22 2 15 22 11 13 2 9 22 2"/></svg>
            Send Quote Request
          </button>
        </div>
        <div class="form-success" id="quoteSuccess">
          <div class="fs-icon">✅</div>
          <h4>Request Received!</h4>
          <p>Thank you — a Triton representative will review your request and reach out at your preferred contact time. We typically respond within one business day.</p>
        </div>
      </div>
    </div>
  </div>
</section>

<!-- FOOTER -->
<footer>
  <div class="foot-inner">
    <div class="foot-logo"><img src="$footLogo" alt="Triton Technologies, Inc."></div>
    <div class="foot-links">
      <a href="index.html">Home</a>
      <a href="about.html">About</a>
      <a href="tti-nvr.html">TTI-NVR</a>
      <a href="tti-ga.html">TTI-GA</a>
      <a href="tti-voip.html">TTI-VoIP</a>
      <a href="paybill.html">Pay Bill</a>
      <a href="policy.html">Privacy Policy</a>
    </div>
    <div class="foot-copy">© 2026 Triton Technologies, Inc. All rights reserved.</div>
  </div>
</footer>

<!-- TOAST -->
<div class="toast" id="toast">
  <span class="toast-icon" id="toast-icon">📤</span>
  <span id="toast-msg">Sending your request…</span>
</div>

<script>
function fieldVal(id){ const e=document.getElementById(id); return e?e.value.trim():''; }
function radioVal(name){ const s=document.querySelector('input[name="'+name+'"]:checked'); return s?s.value:''; }

function showToast(icon, msg){
  document.getElementById('toast-icon').textContent = icon;
  document.getElementById('toast-msg').textContent  = msg;
  const t = document.getElementById('toast');
  t.classList.add('show');
}
function hideToast(){ document.getElementById('toast').classList.remove('show'); }

function submitQuote(){
  const name  = fieldVal('f-name');
  const phone = fieldVal('f-phone');
  const email = fieldVal('f-email');
  if(!name||!phone||!email){ alert('Please fill in your name, phone, and email to continue.'); return; }

  const btn = document.querySelector('.submit-btn');
  btn.disabled = true;

  showToast('📤','Sending your request…');

  const payload = {
    name:       name,
    company:    fieldVal('f-company'),
    phone:      phone,
    email:      email,
    extensions: fieldVal('f-extensions'),
    mobile:     fieldVal('f-mobile'),
    hasSystem:  radioVal('has-system'),
    current:    fieldVal('f-current'),
    timeframe:  radioVal('timeframe'),
    contactTime:fieldVal('f-contact-time'),
    notes:      fieldVal('f-notes')
  };

  fetch('send-voip-quote.php',{
    method:'POST',
    headers:{'Content-Type':'application/json'},
    body:JSON.stringify(payload)
  })
  .then(function(r){ return r.json(); })
  .then(function(d){
    if(d.success){
      hideToast();
      setTimeout(function(){
        showToast('✅','Request sent!');
        setTimeout(function(){
          hideToast();
          document.getElementById('quoteFormInner').style.display='none';
          document.getElementById('quoteSuccess').style.display='block';
          setTimeout(function(){ window.scrollTo({top:0,behavior:'smooth'}); }, 2000);
        },1000);
      },200);
    } else {
      hideToast();
      alert('There was a problem: '+(d.error||'Unknown error.'));
      btn.disabled=false;
    }
  })
  .catch(function(){
    hideToast();
    alert('Network error. Please try again or call us directly.');
    btn.disabled=false;
  });
}
</script>
</body>
</html>
"@

Set-Content 'C:/Users/admin/Desktop/websitefull/tti-voip.html' -Value $html -NoNewline
Write-Host "tti-voip.html written. Size: $($html.Length) chars"
