--オルターガイスト・フィジアラート (Anime)
--Altergeist Fijialert (Anime)
--Scripted by Larry126
local s,c511600364,alias=GetID()
function c511600364.initial_effect(c)
	alias=c:GetOriginalCodeRule()
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringc511600364(alias,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_DELAY+EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetRange(LOCATION_HAND)
	e1:SetCountLimit(1,alias)
	e1:SetCondition(c511600364.spcon)
	e1:SetTarget(c511600364.sptg)
	e1:SetOperation(c511600364.spop)
	c:RegisterEffect(e1)
	--altergeist
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringc511600364(alias,1))
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1,{alias,1})
	e2:SetTarget(c511600364.target)
	e2:SetOperation(c511600364.operation)
	c:RegisterEffect(e2)
end
c511600364.listed_series={0x103}
function c511600364.cfilter(c,tp)
	return c:IsControler(tp) and c:IsSetCard(0x103) and c:IsType(TYPE_LINK) and c:IsSummonType(SUMMON_TYPE_LINK)
end
function c511600364.spcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c511600364.cfilter,1,nil,tp)
end
function c511600364.filter(c,e,tp)
	return c:IsType(TYPE_LINK) and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false,POS_FACEUP,tp,c:GetLinkedZone(tp)&0x1f)
end
function c511600364.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and c511600364.filter(chkc,e,tp) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingTarget(c511600364.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,eg:Filter(c511600364.cfilter,nil,tp),e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	Duel.SelectTarget(tp,c511600364.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,eg:Filter(c511600364.cfilter,nil,tp),e,tp)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c511600364.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	local zone=tc:GetLinkedZone(tp)&0x1f
	if c:IsRelateToEffect(e) and tc:IsRelateToEffect(e) and zone>0 then
		Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP,zone)
	end
end
function c511600364.filter2(c)
	return c:IsType(TYPE_LINK) and not c:IsSetCard(0x103)
end
function c511600364.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_MZONE) and c511600364.filter2(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c511600364.filter2,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	Duel.SelectTarget(tp,c511600364.filter2,tp,LOCATION_MZONE,0,1,1,nil)
end
function c511600364.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if tc:IsFaceup() and tc:IsRelateToEffect(e) and c:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(c)
		e1:SetDescription(aux.Stringc511600364(alias,1))
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_CLIENT_HINT)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_ADD_SETCODE)
		e1:SetValue(0x103)
		e1:SetCondition(c511600364.con)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD)
		tc:RegisterEffect(e1)
		c:CreateEffectRelation(e1)
	end
end
function c511600364.con(e)
	if e:GetOwner():IsRelateToEffect(e) then return true
	else e:Reset() return false end
end