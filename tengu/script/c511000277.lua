--ＣＮｏ．１ ゲート・オブ・カオス・ヌメロン－シニューニャ
--Number C1: Numeron Chaos Gate Sunya (anime)
function c511000277.initial_effect(c)
	--Xyz summon
	aux.AddXyzProcedure(c,nil,2,4,c511000277.ovfilter,aux.Stringc511000277(c511000277,0))
	c:EnableReviveLimit()
	--Destroy itself
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetCode(EFFECT_SELF_DESTROY)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCondition(c511000277.descon)
	c:RegisterEffect(e1)
	--Remove monsters
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringc511000277(c511000277,1))
	e2:SetCategory(CATEGORY_REMOVE)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	e2:SetCondition(c511000277.bancon)
	e2:SetTarget(c511000277.bantg)
	e2:SetOperation(c511000277.banop)
	c:RegisterEffect(e2)
	--Battle indestructable
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e3:SetValue(aux.NOT(aux.TargetBoolFunction(Card.IsSetCard,0x48)))
	c:RegisterEffect(e3)
end
c511000277.listed_series={0x48}
c511000277.listed_names={CARD_NUMERON_NETWORK}
c511000277.aux.xyz_number=1
function c511000277.ovfilter(c,tp,lc)
	return c:IsFaceup() and c:IsSummonCode(lc,SUMMON_TYPE_XYZ,tp,15232745) and Duel.IsEnvironment(CARD_NUMERON_NETWORK)
end
function c511000277.descon(e)
	return not Duel.IsEnvironment(CARD_NUMERON_NETWORK)
end
function c511000277.bancon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsSummonType(SUMMON_TYPE_XYZ)
end
function c511000277.bantg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local g=Duel.GetMatchingGroup(Card.IsAbleToRemove,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,g,#g,0,0)
end
function c511000277.banop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local chk=c:IsRelateToEffect(e)
	local g=Duel.GetMatchingGroup(Card.IsAbleToRemove,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
	local atk=0
	for tc in aux.Next(g) do
		local a=tc:GetAttack()
		if a<0 or tc:IsFacedown() then a=0 end
		atk=atk+a
	end
	if Duel.Remove(g,POS_FACEUP,REASON_EFFECT)>0 and chk then
		local e3=Effect.CreateEffect(c)
		e3:SetDescription(aux.Stringc511000277(c511000277,2))
		e3:SetCategory(CATEGORY_SPECIAL_SUMMON)
		e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
		e3:SetRange(LOCATION_REMOVED)
		e3:SetCode(EVENT_PHASE+PHASE_STANDBY)
		e3:SetCondition(c511000277.spcon)
		e3:SetTarget(c511000277.sptg)
		e3:SetOperation(c511000277.spop)
		e3:SetLabel(atk)
		e3:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_STANDBY+RESET_SELF_TURN)
		c:RegisterEffect(e3)
		c:RegisterFlagEffect(c511000277,RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_STANDBY+RESET_SELF_TURN,0,1)
	end
end
function c511000277.spcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:GetTurnID()~=Duel.GetTurnCount() and tp==Duel.GetTurnPlayer() and c:GetFlagEffect(c511000277)>0
end
function c511000277.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local c=e:GetHandler()
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,c,1,0,0)
	c:ResetFlagEffect(c511000277)
end
function c511000277.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(c)
		e1:SetDescription(aux.Stringc511000277(c511000277,3))
		e1:SetCategory(CATEGORY_DAMAGE)
		e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
		e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
		e1:SetCode(EVENT_SPSUMMON_SUCCESS)
		e1:SetCondition(c511000277.damcon)
		e1:SetCost(aux.dxmcostgen(1,1,nil))
		e1:SetTarget(c511000277.damtg)
		e1:SetOperation(c511000277.damop)
		e1:SetLabel(e:GetLabel())
		e1:SetReset(RESET_EVENT+RESETS_STANDARD-RESET_TOFIELD)
		c:RegisterEffect(e1,false,REGISTER_FLAG_DETACH_XMAT)
		Duel.SpecialSummon(c,1,tp,tp,false,false,POS_FACEUP)
	end
end
function c511000277.damcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsSummonType(SUMMON_TYPE_SPECIAL+1)
end
function c511000277.damtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetTargetPlayer(1-tp)
	Duel.SetTargetParam(e:GetLabel())
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,e:GetLabel())
end
function c511000277.damop(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Damage(p,d,REASON_EFFECT)
end