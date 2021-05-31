Chapter VIII : General Data Protection Regulation - GDPR
======================================================

## Respect of the private life

As little data as possible is collected and kept on the website to respect GDPR guidelines.
Therefore, inactive customers are deleted within 3 days since there is no need to keep their information stored 
in the database.

```{.java caption="GDPR Example"}

 /**
  * Not activated users should be automatically deleted after 3 days.
  * This is scheduled to get fired everyday, at 01:00 (am).
  */
  
  @Override
  @Scheduled(cron = "0 0 1 * * ?")
  public void removeNotActivatedUsers() {
    userDAO
      .deleteNotActivateUsers(Instant.now().minus(3, ChronoUnit.DAYS))
      .forEach(userDAO::delete);
  }

```

## Future Enhancements

\def\checkmark{\tikz\fill[scale=0.4](0,.35) -- (.25,0) -- (1,.7) -- (.25,.15) -- cycle;}

The GDPR requires two major things, one to be as transparent as possible about how a website collects customer's 
personal data, and secondly to collect only the data that is necessary. 

To fully comply with GDPR, the following should be incorporate in this application website:

  - **The website runs on a secure https connection**. \checkmark

  - **Set up a privacy policy**: Make it available to customers by integrating it into the 
    website's footer. The latter will allow customers to know exactly how their data is collected and for what purpose. 
    It must also specify on which legal mentions this privacy policy is based on. \times 
    
  - **Implement Informed Consent** Informed consent means the customers need to know what data processing 
    activities the company intend to conduct, for what the purpose. It should be clearly stated that customers 
    can withdraw their consent at any time.

    It also means that the explanation of the data collecting activities, and 
    their purpose are explained in plain language (“in an unequivocal and easily accessible page, using clear 
    and plain language”). That means no technical jargon or legalese. Any customer accessing the company's services 
    should be able to understand what the company is asking them to agree to. \times

\pagebreak
