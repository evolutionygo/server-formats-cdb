--転生炎獣 ヴァイオレット・キマイラ (Anime)
--Salamangreat Violet Chimera (Anime)
--scripted by Larry126
local s,c511600182,alias=GetID()
function c511600182.initial_effect(c)
	alias=c:GetOriginalCodeRule()
	--Fusion Material
	c:EnableReviveLimit()
	aux.AddFusionProcCode2(c,true,true,41463181,c511600182.ffilter)
	--Reincarnation Check
	aux.EnableCheckReincarnation(c)
	--ATK UP
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringc511600182(2091298,0))
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_DELAY)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetCondition(c511600182.sumcon)
	e1:SetTarget(c511600182.sumtg)
	e1:SetOperation(c511600182.sumop)
	c:RegisterEffect(e1)
	--Material Check
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_MATERIAL_CHECK)
	e2:SetValue(c511600182.valcheck)
	e2:SetLabelObject(e1)
	c:RegisterEffect(e2)
	--Double ATK
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringc511600182(60645181,0))
	e3:SetCategory(CATEGORY_ATKCHANGE)
	e3:SetType(EFFECT_TYPE_QUICK_O)
	e3:SetCode(EVENT_PRE_DAMAGE_CALCULATE)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCondition(c511600182.atkcon)
	e3:SetTarget(c511600182.atktg)
	e3:SetOperation(c511600182.atkop)
	c:RegisterEffect(e3)
	--ATK to 0
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_FIELD)
	e4:SetCode(EFFECT_SET_ATTACK)
	e4:SetRange(LOCATION_MZONE)
	e4:SetTargetRange(0,LOCATION_MZONE)
	e4:SetTarget(c511600182.atktg2)
	e4:SetCondition(c511600182.atkcon2)
	e4:SetValue(0)
	c:RegisterEffect(e4)
end
c511600182.material_setcode={0x119}
function c511600182.ffilter(c,fc,sumtype,tp)
	return c:IsType(TYPE_LINK,fc,sumtype,tp) or c:IsSetCard(0x119,fc,sumtype,tp)
end
function c511600182.sumcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsSummonType(SUMMON_TYPE_FUSION)
end
function c511600182.sumtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_ATKCHANGE,e:GetHandler(),1,tp,e:GetLabel()/2)
end
function c511600182.sumop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsFaceup() and c:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
		e1:SetRange(LOCATION_MZONE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(e:GetLabel()/2)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD_DISABLE+RESET_PHASE+PHASE_END)
		c:RegisterEffect(e1)
	end
end
function c511600182.valcheck(e,c)
	local g=c:GetMaterial()
	local atk=g:GetSum(Card.GetBaseAttack)
	e:GetLabelObject():SetLabel(atk)
end
function c511600182.atkcon(e,tp,eg,ep,ev,re,r,rp)
	local bc=e:GetHandler():GetBattleTarget()
	return bc~=nil and bc:GetAttack()~=bc:GetBaseAttack()
end
function c511600182.atktg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return c:GetFlagEffect(c511600182)==0 end
	c:RegisterFlagEffect(c511600182,RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_DAMAGE_CAL+RESET_CHAIN,0,1)
	Duel.SetOperationInfo(0,CATEGORY_ATKCHANGE,c,1,tp,c:GetAttack())
end
function c511600182.atkop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsFaceup() and c:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_SET_ATTACK_FINAL)
		e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
		e1:SetRange(LOCATION_MZONE)
		e1:SetValue(c:GetAttack()*2)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_DAMAGE_CAL)
		c:RegisterEffect(e1)
	end
end
function c511600182.atkcon2(e,tp,eg,ep,ev,re,r,rp)
	local ph=Duel.GetCurrentPhase()
	return e:GetHandler():IsReincarnationSummoned() and ph==PHASE_DAMAGE_CAL
end
function c511600182.atktg2(e,c)
	return c==e:GetHandler():GetBattleTarget()
end