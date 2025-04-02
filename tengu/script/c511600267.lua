--海晶乙女 ワンダーハート
--Marincess Wonder Heart
--scripted by Larry126
local s,c511600267,alias=GetID()
function c511600267.initial_effect(c)
	alias=c:GetOriginalCodeRule()
	--link summon
	c:EnableReviveLimit()
	Link.AddProcedure(c,aux.FilterBoolFunctionEx(Card.IsAttribute,ATTRIBUTE_WATER),2,nil,c511600267.spcheck)
	--special summon equip
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringc511600267(alias,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_PRE_DAMAGE_CALCULATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCondition(c511600267.condition)
	e1:SetTarget(c511600267.target)
	e1:SetOperation(c511600267.operation)
	c:RegisterEffect(e1)
	--equip
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringc511600267(16255173,0))
	e2:SetCategory(CATEGORY_EQUIP)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCode(EVENT_PHASE+PHASE_END)
	e2:SetCountLimit(1)
	e2:SetTarget(c511600267.eqtg)
	e2:SetOperation(c511600267.eqop)
	c:RegisterEffect(e2)
	aux.AddEREquipLimit(c,nil,c511600267.eqval,Card.EquipByEffectAndLimitRegister,e2)
	--battle
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringc511600267(65029288,0))
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_BATTLE_START)
	e3:SetProperty(EFFECT_FLAG_DELAY)
	e3:SetTarget(c511600267.bttg)
	e3:SetOperation(c511600267.btop)
	c:RegisterEffect(e3)
	--change battle target
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringc511600267(79473793,1))
	e4:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e4:SetCode(EVENT_BE_BATTLE_TARGET)
	e4:SetRange(LOCATION_MZONE)
	e4:SetCondition(c511600267.cbcon)
	e4:SetTarget(c511600267.cbtg)
	e4:SetOperation(c511600267.cbop)
	c:RegisterEffect(e4)
	--special summon (gy)
	local e5=Effect.CreateEffect(c)
	e5:SetDescription(aux.Stringc511600267(alias,1))
	e5:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e5:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e5:SetProperty(EFFECT_FLAG_DELAY+EFFECT_FLAG_DAMAGE_STEP)
	e5:SetCode(EVENT_DESTROYED)
	e5:SetTarget(c511600267.sptg)
	e5:SetOperation(c511600267.spop)
	c:RegisterEffect(e5)
end
c511600267.listed_series={0x12b}
c511600267.listed_names={67712104}
function c511600267.spcheck(g,lc,sumtype,tp)
	return g:IsExists(Card.IsSummonCode,1,nil,lc,sumtype,tp,67712104)
end
function c511600267.condition(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetBattleTarget() and not e:GetHandler():GetBattleTarget():IsControler(tp)
end
function c511600267.filter(c,e,tp)
	return c:GetOriginalType()&(TYPE_LINK+TYPE_MONSTER)==(TYPE_LINK+TYPE_MONSTER)
		and c:IsSetCard(0x12b) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c511600267.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:GetEquipTarget()==e:GetHandler() and c511600267.filter(chkc) end
	local c=e:GetHandler()
	if chk==0 then return c:GetEquipGroup():IsExists(c511600267.filter,1,nil,e,tp) and c:GetFlagEffect(c511600267)==0 end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	local g=e:GetHandler():GetEquipGroup():FilterSelect(tp,c511600267.filter,1,1,nil,e,tp)
	Duel.SetTargetCard(g)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,0,0)
	c:RegisterFlagEffect(c511600267,RESET_CHAIN,0,1)
end
function c511600267.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c and c:IsRelateToEffect(e) and c:IsRelateToBattle() then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
		e1:SetValue(1)
		e1:SetReset(RESET_PHASE+PHASE_DAMAGE)
		c:RegisterEffect(e1)
	end
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_PRE_BATTLE_DAMAGE)
	e2:SetOperation(c511600267.damop)
	e2:SetReset(RESET_PHASE+PHASE_DAMAGE)
	Duel.RegisterEffect(e2,tp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) then
		local e3=Effect.CreateEffect(c)
		e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		e3:SetCode(EVENT_BATTLED)
		e3:SetLabelObject(tc)
		e3:SetCondition(c511600267.speqcon)
		e3:SetOperation(c511600267.speqop)
		Duel.RegisterEffect(e3,tp)
		tc:CreateEffectRelation(e3)
	end
end
function c511600267.damop(e,tp,eg,ep,ev,re,r,rp)
	Duel.ChangeBattleDamage(tp,0)
end
function c511600267.speqcon(e,tp,eg,ep,ev,re,r,rp)
	if e:GetLabelObject() and e:GetLabelObject():IsRelateToEffect(e) then return true
	else e:Reset() return false end
end
function c511600267.speqop(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetLabelObject()
	if Duel.SpecialSummonStep(tc,0,tp,tp,false,false,POS_FACEUP) then
		local c=e:GetOwner()
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_DISABLE)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD)
		tc:RegisterEffect(e1)
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_DISABLE_EFFECT)
		e2:SetReset(RESET_EVENT+RESETS_STANDARD)
		tc:RegisterEffect(e2)
		tc:RegisterFlagEffect(c511600267,RESET_EVENT+RESETS_STANDARD,0,1,c:GetFieldID())
		Duel.SpecialSummonComplete()
	end
end
function c511600267.eqval(ec,c,tp)
	return ec:IsSetCard(0x12b) and ec:IsType(TYPE_LINK) 
end
function c511600267.eqfilter(c,fc511600267)
	return c:GetFlagEffectLabel(c511600267)==fc511600267 and c:IsFaceup() and c:IsType(TYPE_LINK) and c:IsSetCard(0x12b) and not c:IsForbc511600267den()
end
function c511600267.eqtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and c511600267.eqfilter(chkc,e:GetHandler():GetFieldID()) end
	local c=e:GetHandler()
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_SZONE)>0
		and Duel.IsExistingTarget(c511600267.eqfilter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil,c:GetFieldID()) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EQUIP)
	local g=Duel.SelectTarget(tp,c511600267.eqfilter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil,c:GetFieldID())
	Duel.SetOperationInfo(0,CATEGORY_EQUIP,g,1,0,0)
end
function c511600267.eqop(e,tp,eg,ep,ev,re,r,rp,chk)
	if Duel.GetLocationCount(tp,LOCATION_SZONE)<=0 then return end
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if c:IsFaceup() and c:IsRelateToEffect(e) and tc and tc:IsRelateToEffect(e) then
		c:EquipByEffectAndLimitRegister(e,tp,tc)
	end
end
function c511600267.bttg(e,tp,eg,ep,ev,re,r,rp,chk)
	local tc=e:GetHandler():GetBattleTarget()
	if chk==0 then return tc and tc:IsControler(1-tp) and tc:IsFaceup() end
end
function c511600267.btop(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetHandler():GetBattleTarget()
	if tc and tc:IsRelateToBattle() and tc:IsFaceup() then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_IMMUNE_EFFECT)
		e1:SetValue(c511600267.tefilter)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_DAMAGE)
		tc:RegisterEffect(e1)
	end
end
function c511600267.tefilter(e,re)
	return e:GetHandler()~=re:GetOwner()
end
function c511600267.cbcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local bt=eg:GetFirst()
	return r~=REASON_REPLACE and c~=bt and bt:IsFaceup() and bt:GetControler()==c:GetControler() and bt:IsSetCard(0x12b)
end
function c511600267.cbtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetAttacker():GetAttackableTarget():IsContains(e:GetHandler()) end
end
function c511600267.cbop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and not Duel.GetAttacker():IsImmuneToEffect(e) then
		Duel.ChangeAttackTarget(c)
	end
end
function c511600267.spfilter(c,e,tp)
	return c:IsCode(101010040) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c511600267.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c511600267.spfilter,tp,LOCATION_GRAVE,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,0,0)
end
function c511600267.spop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local tc=Duel.SelectMatchingCard(tp,aux.NecroValleyFilter(c511600267.spfilter),tp,LOCATION_GRAVE,0,1,1,nil,e,tp):GetFirst()
	if tc then Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP) end
end