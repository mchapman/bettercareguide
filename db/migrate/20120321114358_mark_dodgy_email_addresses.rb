class MarkDodgyEmailAddresses < ActiveRecord::Migration
  def self.up
    Organisation.connection.execute("update organisations set main_email = '?'||main_email||'?' where main_email in (
        'abbeycourt@fshc.co.uk',
        'ablecomcareteam@aol.com',
        'adamhillhouse@tpaberdeen.co.uk',
        'adamhouse@fshc.co.uk',
        'aileen.forrest@quarriers.org.uk',
        'airliehouse@aol.com',
        'achievementbute@btconnect.com',
        'admin@abbeyfield-springburn.co.uk',
        'alana.jones@fife.gov.co.uk',
        'ann.giles@edinbugh.gov.uk','care113@denovanstables.co.uk','brian.oneill@theaplhaproject.org.uk',
        'alisonir@dumgal.gov.uk',
        'altonreagardens@cornerstone.org.uk',
        'andrew.gordon@vsa.org.uk',
        'angela.macleodt@west-dunbarton.gov.uk',
        'annahampson@renfrewshire.gov.uk',
        'anna@elitehomecare.co.uk',
        'alexanderconnor@tiscali.co.uk',
        'angusdivmgr@aol.com',
        'ashgrove-quarriers@totalise.co.uk',
        'astrid@rigifa.supanet.com',
        'barbara.hacking@edinburgh.gov.uk',
        'banksodee@fshc.co.uk',
        'barbara.robson@search.co.uk',
        'bdds@freeuk.com',
        'birkhall.parade@cornerstone.org.uk',
        'bobb3@dumgal.gov.uk',
        'birchview@cornerstone.org.uk',
        'brendaagnew@lcdisability.org',
        'betty.rae@lpct.scot.nhs.uk',
        'bowenmar@bupa.com',
        'bryansmith.cyrenians@virgin.net',
        'bryce@inclusion.freeserve.co.uk',
        'averley@scotborders.gov.uk',
        'caragenholm@canterbury-care.com',
        'agallagher@cne-siar.gov.uk',
        'caremanager.glasgowuk@nazarethcare.com',
        'campjenn@btconnect.com',
        'carnold@clacks.gov.uk',
        'carole.sands@inspire.org.uk',
        'catherine.tooke@renfrewshire.gov.uk',
        'care@bonnytonhouse.com',
        'carolyngds@tiscali.co.uk',
        'caroltoncare@btconnect.com',
        'carole.taylor@highland.gov.uk',
        'carntyne.carehouse@btconnect.com',
        'cathy.robertson@argyll-bute.gov.uk',
        'claire.garven@dundeecity.gov.uk',
        'cindy.clark@orkney.gov.uk',
        'cing161246@aol.com',
        'connierussell@sic.shetland.gov.uk',
        'cmcluskey@trfs.org',
        'claire.kennedy@south-ayrshire.gov.uk',
        'cooper@sensescotland.org.uk',
        'dementia@elac.freeserve.co.uk',
        'dayservices@glenesk.wanadoo.co.uk',
        'ddc@bdc102.freeserve.co.uk',
        'dereklavan@hotmail.com',
        'denise@familycircles.org',
        'dmalcy@aol.com',
        'drumchapelsa@freeuk.com',
        'doocotview.respite@cornerstone.org.uk',
        'dunwhinny.dc@freeuk.co.uk',
        'easterhill.sa@samhservices.org.uk',
        'eleanor.fisher@renfrewshire.gov.uk',
        'edinburgh.sl@enable.org.uk',
        'elizabeth.williams@c-i-c.co.uk',
        'falkirk@carr-gommscotland.org.uk',
        'fiona.campbellmowatt@servite.co.uk',
        'flong@meadmedica.co.uk',
        'forres@hsha.org.uk',
        'francesmcleod@highland.gov.uk',
        'gail.mcnamara@falkirk.gov.uk',
        'gblaikie@bield.co.uk',
        'gillianb@bield.co.uk',
        'gladys@pitcairn.force9.co.uk',
        'glasgowsea@aol.com',
        'glebefield.terrace@cornerstone.org.uk',
        'glencairnlodge@hotmail.com',
        'granton.place@cornerstone.org.uk',
        'gordon.mcleod@highland.gov.uk',
        'glenhelenbank@aol.com',
        'gwynethl@abbeyhealthcare.org.uk',
        'hcus@scvo.org.uk',
        'healthcare@home.co.uk',
        'hiltonhomecare@cd.com',
        'helen@swintonhill.co.uk',
        'hiltoncourt@meallmorelodge.co.uk',
        'hilary.plenderleith@argyll-bute.gov.uk',
        'hollanch@bupa.com',
        'ian.bell@salvationarmy.co.uk',
        'ian.brown@positivesteps.org.uk',
        'eroarty@alzscot.org',
        'info@abbeysidenursinghome.co.uk',
        'horizonsdropincentre@tiscali.co.uk',
        'jaitken@maryhill.org.uk',
        'janetteirvine@southlanarkshire.gov.uk',
        'jimmu@dumgal.gov.uk',
        'jenniferallan@scotnursing.com',
        'jim.holden@cairnha.com',
        'jenningj@bupa.com',
        'gerry.mckenna@southlanarkshire.gov.uk',
        'jim.nichols@autisminitiatives.org',
        'joan@carersdomestic.fsnet.co.uk',
        'kate.winstanley@samhservices.org.uk',
        'julieglen@southlanarkshire.gov.uk',
        'kathryn@grangemouthcarers.wanadoo.co.uk',
        'kate@abbeysidenursinghome.co.uk',
        'kaylorimer@erskine.org.uk',
        'karenwaton@turningpointscotland.com',
        'karentaylor-sw@fife.gov.uk',
        'kathleen.stuart@inspiremail.org.uk',
        'kenny.mckenzie@vsa.org.uk',
        'junction52@capability-scotland.org.uk',
        'kerrymarr@edinburgh.gov.uk',
        'kennyt_penumbra@yahoo.co.uk',
        'katrina.macnab@btconnect.com',
        'k.mackenzie@cne-siar.gov.uk',
        'lesleywhiteside@actiongroup.org.uk',
        'knowesouth@guardian-care.com',
        'lesleym@mbha.org.uk',
        'ledmoresa@samhservices.org.uk',
        'linlathen.house@fshc.co.uk',
        'loe.woods@nhs.net',
        'liz.mcfarlane@careuk.com',
        'lynn.angus@quarriers.org.uk',
        'lynnemc62@hotmail.com',
        'manager.galashiels@arkha.org.uk',
        'manager.dunfermline@arkha.org.uk',
        'manager.perth@arkha.org.uk',
        'mail@carrickview.fsnet.co.uk',
        'manager.penicuik@arkha.org.uk',
        'manager.alloa@arkha.org.uk',
        'manager.kelso@arkha.org.uk',
        'mail@lynedoch.co.uk',
        'manorproject1989@fsmail.net',
        'margaret.caskie-mcseveney@fife.gov.uk',
        'margaretreid@fife.gov.uk',
        'ehunter@alzscot.org',
        'martc@mbha.org.uk',
        'maureen.mcsevleney@fife.gov.uk',
        'marlene.harkis@east-ayrshire.gov.uk',
        'marshallb@northlan.gov.uk',
        'colleenlemon@autism-in-scotland.org.uk',
        'marylyn.young@westlothian.gov.uk',
        'mary.abbeyfield@tiscali.co.uk',
        'mary.m.goldrich@renfrewshire.gov.uk',
        'martin@dawson9805.freeserve.co.uk',
        'martin@beesley9103.freeserve.co.uk',
        'mcnaira@northlan.gov.uk',
        'meadowvalemanager@fshc.co.uk',
        'michealpudsey@bethanychristiantrust.com',
        'maurice.nicholson@highland.gov.uk',
        'geraldine.o''neill@themungofoundation.org.uk',
        'mom_penumbra@yahoo.com',
        'moorparkplacem@fshc.co.uk',
        'morags@mbha.org',
        'murrlor@bupa.com',
        'parkvale@cornerstone.org.uk',
        'pamewart@fife.gov.uk',
        'ianhowie@btconnect.com',
        'pamhope.mainhouse@btinternet.com',
        'patriciahughes@bluebirdcare.co.uk',
        'lillie.mccabe@nas.org.uk',
        'paulguppy@sic.shetland.gov.uk',
        'lric@linkhaltd.co.uk',
        'patricia.easton@capability-scotland.org.uk',
        'pat.boyle@highland.gov.uk',
        'peter.allen@phoenixhouse.org.uk',
        'patricia.mccoy@cornerstone.org.uk',
        'paul.oliver@bethanychristiantrust.com',
        'pmshettleston@btha.org',
        'projectmanager.community@lorettoha.co.uk',
        'rainbow@care1.wanadoo.co.uk',
        'r.mitchell@rosturk.co.uk',
        'robert@garvaldwl.fsnet.co.uk',
        'michaelreilly1955@hotmail.co.uk',
        'robinsonm@northlan.gov.uk',
        'seabank.house@virgin.net',
        'safeandsoundcare@lineone.net',
        'school.park@cornerstone.org.uk',
        'shelagh.campbell@east-ayrshire.gov.uk',
        'senga.mcculloch@east-ayrshire.gov.uk',
        'manager@willowbankcare.co.uk',
        'sheenah@robertson5614.fslife.co.uk',
        'shirleycameron@aol.com',
        'shoremill.carehome@virgin.net',
        'stopover.quariers@btopenworld.com',
        'janet.ellie@reallifeoptions.org',
        'srbrenda@hotmail.com',
        'sterlingcare@bt.com',
        'stuart.hanney@sic.shetland.gov.uk',
        'stevenson.court@cornerstone.org.uk',
        'supportingpeople@headway.plus.com',
        'sum@autisminitiatives.org',
        'staubins@btconnect.com',
        'susan.dillet@scot.nhs.uk',
        't2.thomson@bield.co.uk',
        'homelessnessservice@scotborders.gov.uk',
        'tainghouse@sic.shetland.gov.uk',
        'tarriebank@aol.com',
        'tracey.gillius@keycommunitysupports.org',
        'trish@kippenhouse.net',
        'tracey.young@lcdisability.org',
        'theresa@fitzsimmons.fsnet.co.uk',
        'wallsidegrange@canterbury-care.com',
        'info@bedssupportedhousing.co.uk',
        'info@blossomssupportedliving.com',
        'wakefiel@craigardcare.com',
        'tracy.gilius@keyhousing.org',
        'info@osjct.co.uk',
        'info@actionforchildren.org.uk',
        'walkepa@bupa.com',
        'info@aaminahomecare.com',
        'val.stevens@cornerstone.org.uk',
        'info@carewell.co.uk',
        'wendywilliamson@trfs.org',
        'info@magnatacare.co.uk',
        'westwood@gatehealthcare.com',
        'williammckay@turningpointscotland.com',
        'info@carers-with-care.co.uk',
        'woodsidereshome@hotmail.co.uk',
        'info@stjohnswinchester.co.uk',
        'yuenman@mecopp.org.uk',
        'zandra@familycircles.org',
        'stonehaven@alzscot.org',
        'threetowns@alzscot.org',
        'wickservice@alzscot.org',
        'patriciacostello@eastdunbarton.gov.uk',
        'ulundiroad@tiscali.co.uk',
        'webster@autism-in-scotland.org.uk',
        'glenmhor@btconnect.com',
        'jachealth@btconnect.com',
        'rtaylor@scotborders.gsx.gov.uk',
        'keithlodge@crossreach.org.uk',
        'admin@abbeyfield-springburn.co.uk',
        'care113@denovanstables.co.uk',
        'brian.oneill@theaplhaproject.org.uk',
        'drew@carmansic.com',
        'enquiries@southfieldhcs.com',
        'info@seabankcare.com',
        'jim.harper@asistproject.co.uk',
        'manager@alastreanhouse.co.uk',
        'mary.strang@quarriersdrumchapel.org.uk',
        'meadows@tamaris.co.uk',
        'm.russell@mansefieldcare.co.uk',
        'matron@themeadowscarehome.co',
        'scedyh@mail.nch.org.uk',
        'c.macdonald@btconnect.com')")
    Organisation.connection.execute("update organisations set main_email = '!'||main_email||'!' where main_email in ('lspdundee@aol.com','linda_paterson4@hotmail.co.uk')")
    Organisation.connection.execute("update organisations set main_email='amoir@epilepsyscotland.org.uk' where main_email='amoir@epilepsyscotlandcss.org.uk'")
    Organisation.connection.execute("update organisations set main_email='amck@linkhaltd.co.uk' where main_email='amck@linkhaltd.com'")
    Organisation.connection.execute("update organisations set main_email='annfor@santuary-group.co.uk' where main_email='annfor@santuary-housing.co.uk'")
    Organisation.connection.execute("update organisations set main_email='admin@fairfieldcarescotland.co.uk' where main_email='admin@fairfieldscotland.co.uk'")
    Organisation.connection.execute("update organisations set main_email='wyvishouse@rdshealthcare.co.uk' where main_email='anna.copple@wyvishouse.co.uk'")
    Organisation.connection.execute("update organisations set main_email='alana.jones@fife.gov.uk' where main_email='alana.jones@fife.gov.co.uk'")
    Organisation.connection.execute("update organisations set main_email='ann.giles@edinburgh.gov.uk' where main_email='ann.giles@edinbugh.gov.uk'")
    Organisation.connection.execute("update organisations set main_email='carbethstreet@themungofoundation.org.uk' where main_email='carbethstreet@themungofoundatio.org.uk'")
    Organisation.connection.execute("update organisations set main_email='glhomes@grandlodgescotland.org' where main_email='bridgeofweir@scottishmasonichomes.org'")
    Organisation.connection.execute("update organisations set main_email='brucefield@stirling.gov.uk' where main_email='brucefield@stir.gov.uk'")
    Organisation.connection.execute("update organisations set main_email='cathy.brien@forgewoodcoop.org.uk' where main_email='cathy.brien@forgewoodcoup.org.uk'")
    Organisation.connection.execute("update organisations set main_email='carolgraham@southlanarkshire.gov.uk' where main_email='carolgraham@southlanarkshirecouncil.gov.uk'")
    Organisation.connection.execute("update organisations set main_email='cindy.clark@orkney.gov.uk' where main_email='cindy.clark@ork.gov.uk'")
    Organisation.connection.execute("update organisations set main_email='dean.aftercare@btconnect.com' where main_email='dean.aftercare@btconnect.co.uk'")
    Organisation.connection.execute("update organisations set main_email='duncan.wright@housecallcare.co.uk' where main_email='duncan.wright@housecallcareagency.co.uk'")
    Organisation.connection.execute("update organisations set main_email='glhomes@grandlodgescotland.org' where main_email='edinburgh@scottishmasonichomes.org'")
    Organisation.connection.execute("update organisations set main_email='elgin@alzscotl.org' where main_email='elgin@alzscotl.org'")
    Organisation.connection.execute("update organisations set main_email='elisabeth@beannachar.org' where main_email='elisabeth@beannacher.org'")
    Organisation.connection.execute("update organisations set main_email='dundee.cst@samhservices.org.uk' where main_email='dundee.cst@samhservices.ors.uk'")
    Organisation.connection.execute("update organisations set main_email='florencehouse@lambhillcourt.ltd.uk' where main_email='florencehouse@lambhillcourtltd.co.uk'")
    Organisation.connection.execute("update organisations set main_email='g.philp@scotborders.gov.uk' where main_email='g.philp@scotbroders.gov.uk'")
    Organisation.connection.execute("update organisations set main_email='forfar@forfardaycare.wanadoo.co.uk' where main_email='forfar@forfardaycare.wanadoo.co.co.uk'")
    Organisation.connection.execute("update organisations set main_email='harlequins.project@moray.gov.uk' where main_email='harlequins.project@moray.gov.co.uk'")
    Organisation.connection.execute("update organisations set main_email='info@cregganbahn.co.uk' where main_email='info@creggganbahn.co.uk'")
    Organisation.connection.execute("update organisations set main_email='info@ailsacare.co.uk' where main_email='info@ailsaservices.co.uk'")
    Organisation.connection.execute("update organisations set main_email='isobel.price@lcdisability.org' where main_email='isobel.price@lc-co.uk'")
    Organisation.connection.execute("update organisations set main_email='jeanette.mccann@west-dunbarton.gov.uk' where main_email='jeanette.mccann@west-dunbartonshire.gov.uk'")
    Organisation.connection.execute("update organisations set main_email='ireneedgar@carrgomm.org' where main_email='ireneedgar@carr-commscotland.org.uk'")
    Organisation.connection.execute("update organisations set main_email='karentaylor@fife.gov.uk' where main_email='karentaylor@fife.gov.net'")
    Organisation.connection.execute("update organisations set main_email='lhughes@alzscotl.org' where main_email='lhughes@allzscot.org'")
    Organisation.connection.execute("update organisations set main_email='linda@heatherfield.org.uk' where main_email='linda@heatherfield.org'")
    Organisation.connection.execute("update organisations set main_email='Avonhaugh@carechoice.ltd.uk' where main_email='keithgreene@carechoice.ltd.co.uk'")
    Organisation.connection.execute("update organisations set main_email='macdonaldel@stirling.gov.uk' where main_email='macdonaldel@stir.gov.uk'")
    Organisation.connection.execute("update organisations set main_email='managerlisden@balhousiecare.co.uk' where main_email='manager@lisdennursinghome.co.uk'")
    Organisation.connection.execute("update organisations set main_email='lorraine.fraser@quarriers.org.uk' where main_email='lorriane.fraser@quarriersjsp.org.uk'")
    Organisation.connection.execute("update organisations set main_email='linda.mccallion@southlanarkshire.gov.uk' where main_email='linda.mccallion@southlanarkshirecouncil.gov.uk'")
    Organisation.connection.execute("update organisations set main_email='managergrange@balhousiecare.co.uk' where main_email='manager@grangebalbeggie.co.uk'")
    Organisation.connection.execute("update organisations set main_email='margaret.duncan@westlothian.gov.uk' where main_email='margaret.duncan@westlothain.gov.uk'")
    Organisation.connection.execute("update organisations set main_email='mike.redgrave@waverleycare.org' where main_email='mike.redgrave@waverelycare.org'")
    Organisation.connection.execute("update organisations set main_email='office@camphillblairdrummond.org.uk' where main_email='office@camphillbalirdrummond.org.uk'")
    Organisation.connection.execute("update organisations set main_email='rebecca.allen@freespacescotland.org' where main_email='rebecca.allen@freespacescotland.gov.uk'")
    Organisation.connection.execute("update organisations set main_email='suzanne.somerville@west-dunbarton.gov.uk' where main_email='suzanne.somerville@west-dumbarton.gov.uk'")
    Organisation.connection.execute("update organisations set main_email='welcarehomes@btconnect.com' where main_email='welcarehomes@btconnect.co.uk'")
    Organisation.connection.execute("update organisations set main_email='yvonne.greenwood@quarriers.org.uk' where main_email='yvonne.greenwood@quarriers.org.yk'")
    Organisation.connection.execute("update organisations set main_email='info@theslcgroup.co.uk' where main_email='info@theslecgroup.co.uk'")
    Organisation.connection.execute("update organisations set main_email='wilmanelson@libertus.org.uk' where main_email='wilmanelson@laha.org.uk'")

    User.all.each do |u|
      u.email = u.email.downcase
      u.save!
    end

    add_column :users, :reset_password_sent_at, :datetime
    remove_column :users, :remember_token
  end

  def self.down
    remove_column :users, :reset_password_sent_at
    add_column :users, :remember_token, :string
  end
end
