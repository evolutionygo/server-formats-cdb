--コードブレイカー・ウイルスバーサーカー (Anime)
--Codebreaker Virus Berserker (Anime)
--Scripted by Larry126
local s,c511600274,alias=GetID()
function c511600274.initial_effect(c)
	alias=c:GetOriginalCodeRule()
	c:EnableReviveLimit()
	Link.AddProcedure(c,nil,2,3,c511600274.lcheck)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringc511600274(alias,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_DELAY)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetCountLimit(1,alias)
	e1:SetCondition(c511600274.condition)
	e1:SetTarget(c511600274.target)
	e1:SetOperation(c511600274.operation)
	c:RegisterEffect(e1)
	--destroy
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringc511600274(alias,1))
	e2:SetCategory(CATEGORY_DESTROY+CATEGORY_DAMAGE)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1,{alias,1})
	e2:SetTarget(c511600274.destg)
	e2:SetOperation(c511600274.desop)
	c:RegisterEffect(e2)
	--to grave
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e3:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e3:SetCode(EVENT_TO_GRAVE)
	e3:SetOperation(c511600274.regop)
	c:RegisterEffect(e3)
end
c511600274.listed_series={0x13c}
function c511600274.lfilter(c,lc,sumtype,tp)
	return c:IsType(TYPE_LINK,lc,sumtype,tp) and c:IsSetCard(0x13c,lc,sumtype,tp)
end
function c511600274.lcheck(g,lc,sumtype,tp)
	return g:IsExists(c511600274.lfilter,1,nil,lc,sumtype,tp)
end
function c511600274.condition(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetMutualLinkedGroupCount()>0
end
function c511600274.spfilter(c,e,tp,zones)
	return c:IsLevelBelow(4) and c:IsSetCard(0x13c) and c:IsCanBeSpecialSummoned(e,0,tp,false,false,POS_FACEUP_DEFENSE,1-tp,zones)
end
function c511600274.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local zones=aux.GetMMZonesPointedTo(1-tp)
	if chk==0 then return Duel.IsExistingMatchingCard(c511600274.spfilter,tp,LOCATION_HAND+LOCATION_GRAVE,0,1,nil,e,tp,zones) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND+LOCATION_GRAVE)
end
function c511600274.operation(e,tp,eg,ep,ev,re,r,rp)
	local zones=aux.GetMMZonesPointedTo(1-tp)
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE,1-tp,LOCATION_REASON_TOFIELD,zones)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,aux.NecroValleyFilter(c511600274.spfilter),tp,LOCATION_HAND+LOCATION_GRAVE,0,1,math.min(ft,2),nil,e,tp,zones)
	if #g>0 then
		Duel.SpecialSummon(g,0,tp,1-tp,false,false,POS_FACEUP_DEFENSE,zones)
	end
end
function c511600274.damcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetAttackTarget()~=nil
end
function c511600274.filter(c)
	return c:IsFaceup() and c:IsSetCard(0x13c)
end
function c511600274.desfilter(c)
	return c:IsFaceup() and c:IsSpellTrap()
end
function c511600274.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c511600274.desfilter,tp,0,LOCATION_ONFIELD,1,nil)
		and Duel.IsExistingMatchingCard(c511600274.filter,tp,0,LOCATION_MZONE,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,nil,1,1-tp,LOCATION_ONFIELD)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,0)
end
function c511600274.desop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectMatchingCard(tp,c511600274.desfilter,tp,0,LOCATION_ONFIELD,1,Duel.GetMatchingGroupCount(c511600274.filter,tp,0,LOCATION_MZONE,nil),nil)
	if #g>0 and Duel.Destroy(g,REASON_EFFECT)>0 then
		local dam=#Duel.GetOperatedGroup()*600
		Duel.Damage(1-tp,dam,REASON_EFFECT)
	end
end
function c511600274.regop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsReason(REASON_EFFECT) and c:IsReason(REASON_DESTROY) and c:GetReasonPlayer()~=tp
		and c:IsPreviousLocation(LOCATION_ONFIELD) and c:IsPreviousControler(tp) then
		local e1=Effect.CreateEffect(c)
		e1:SetDescription(aux.Stringc511600274(80250185,1))
		e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
		e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
		e1:SetCode(EVENT_PHASE+PHASE_END)
		e1:SetCountLimit(1,{alias,2})
		e1:SetRange(LOCATION_GRAVE)
		e1:SetTarget(c511600274.sptg)
		e1:SetOperation(c511600274.spop)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		c:RegisterEffect(e1)
	end
end
function c511600274.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c511600274.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)>0 then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_LEAVE_FIELD_REDIRECT)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetReset(RESET_EVENT+RESETS_REDIRECT)
		e1:SetValue(LOCATION_REMOVED)
		c:RegisterEffect(e1,true)
	end
end