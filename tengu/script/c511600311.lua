--ヒヤリ＠イグニスター (Anime)
--Hiyari @Ignister (Anime)
--Scripted by Larry126
local s,c511600311,alias=GetID()
function c511600311.initial_effect(c)
	alias=c:GetOriginalCodeRule()
	--Special Summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringc511600311(alias,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_HAND)
	e1:SetCountLimit(1,c511600311)
	e1:SetCondition(c511600311.spcon)
	e1:SetTarget(c511600311.sptg)
	e1:SetOperation(c511600311.spop)
	c:RegisterEffect(e1)
	--search
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringc511600311(alias,1))
	e2:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH+CATEGORY_LVCHANGE)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1,{c511600311,1})
	e2:SetCost(c511600311.thcost)
	e2:SetTarget(c511600311.thtg)
	e2:SetOperation(c511600311.thop)
	c:RegisterEffect(e2)
end
c511600311.listed_names={85327820}
c511600311.listed_series={0x135}
function c511600311.filter(c)
	return c:IsType(TYPE_LINK) and c:IsFaceup() and c:GetSequence()>4
end
function c511600311.spcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c511600311.filter,tp,LOCATION_MZONE,0,1,nil)
end
function c511600311.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	local zones=aux.GetMMZonesPointedTo(tp,nil,LOCATION_MZONE,0)
	if chk==0 then return zones>0 and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false,POS_FACEUP,tp,zones) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,tp,LOCATION_HAND)
end
function c511600311.spop(e,tp,eg,ep,ev,re,r,rp)
	local zones=aux.GetMMZonesPointedTo(tp,nil,LOCATION_MZONE,0)
	if not e:GetHandler():IsRelateToEffect(e) or zones==0 then return end
	Duel.SpecialSummon(e:GetHandler(),0,tp,tp,false,false,POS_FACEUP,zones)
end
function c511600311.thcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckReleaseGroupCost(tp,Card.IsSetCard,1,false,nil,e:GetHandler(),0x135) end
	local g=Duel.SelectReleaseGroupCost(tp,Card.IsSetCard,1,1,false,nil,e:GetHandler(),0x135)
	Duel.Release(g,REASON_COST)
	e:SetLabelObject(g:GetFirst())
end
function c511600311.thfilter(c)
	return c:IsCode(85327820) and c:IsAbleToHand()
end
function c511600311.thfilter2(c)
	return c:IsSetCard(0x135) and c:IsRitualMonster() and c:IsAbleToHand()
end
function c511600311.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c511600311.thfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c511600311.thop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c511600311.thfilter,tp,LOCATION_DECK,0,1,1,nil)
	if #g>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
	local lc=e:GetLabelObject()
	if lc:IsType(TYPE_LINK) then
		local tg=Duel.GetMatchingGroup(c511600311.thfilter2,tp,LOCATION_DECK,0,nil)
		if #tg>0 and Duel.SelectYesNo(tp,aux.Stringc511600311(alias,2)) then
			Duel.SendtoHand(tg:Select(tp,1,1,nil),nil,REASON_EFFECT)
			Duel.ConfirmCards(1-tp,Duel.GetOperatedGroup())
		end
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_LEVEL)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD_DISABLE+RESET_PHASE+PHASE_END)
		e1:SetValue(lc:GetLink())
		e:GetHandler():RegisterEffect(e1)
	end
end