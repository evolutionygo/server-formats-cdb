--No.62 銀河眼の光子竜皇 (Anime)
--Number 62: Galaxy-Eyes Prime Photon Dragon (Anime)
--scripted by TheOnePharaoh, MLD and Larry126
Duel.LoadCardScript("c31801517.lua")
function c511010062.initial_effect(c)
	c:EnableReviveLimit()
	--Xyz Summon Procedure
	aux.AddXyzProcedure(c,nil,8,2)
	--Gains ATK while it battles
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCondition(c511010062.atkcon)
	e1:SetValue(c511010062.atkval)
	c:RegisterEffect(e1)
	--Register an effect if it leaves the field
	local e3=Effect.CreateEffect(c)
	e3:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e3:SetCode(EVENT_LEAVE_FIELD)
	e3:SetOperation(c511010062.op)
	c:RegisterEffect(e3)
	--Increase the Ranks of all monsters by 1
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringc511010062(c511010062,0))
	e4:SetType(EFFECT_TYPE_IGNITION)
	e4:SetRange(LOCATION_MZONE)
	e4:SetCountLimit(1)
	e4:SetTarget(c511010062.rktg)
	e4:SetOperation(c511010062.rkop)
	c:RegisterEffect(e4)
	--Cannot be destroy by battle with non-"Number" monsters
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_SINGLE)
	e5:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e5:SetValue(function(e,cc) return not cc:IsSetCard(SET_NUMBER) end)
	c:RegisterEffect(e5)
	--Monsters aree treated as having ranks equal to their levels
	local e6=Effect.CreateEffect(c)
	e6:SetType(EFFECT_TYPE_FIELD)
	e6:SetRange(LOCATION_MZONE)
	e6:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e6:SetCode(EFFECT_LEVEL_RANK_S)
	e6:SetTarget(function(e,cc) return cc:HasLevel() end)
	c:RegisterEffect(e6)
end
c511010062.aux.xyz_number=62
c511010062.listed_series={SET_NUMBER}
function c511010062.atkcon(e)
	return Duel.GetBattleMonster(e:GetHandlerPlayer())==e:GetHandler()
end
function c511010062.atkval(e,c)
	local g=Duel.GetMatchingGroup(Card.IsFaceup,0,LOCATION_MZONE,LOCATION_MZONE,nil)
	return g:GetSum(Card.GetRank)*200
end
function c511010062.op(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local g=c:GetOverlayGroup()
	--Special Summon this card during your next Standby Phase
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringc511010062(c511010062,1))
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e1:SetCode(c511010062)
	e1:SetLabel(#g)
	e1:SetCondition(c511010062.spcon)
	e1:SetOperation(c511010062.spop)
	e1:SetReset(RESET_EVENT|RESETS_STANDARD)
	c:RegisterEffect(e1)
	Duel.RaiseSingleEvent(c,c511010062,re,r,rp,ep,ev)
end
function c511010062.spcon(e,tp,eg,ep,ev,re,r,rp)
	local ct=e:GetLabel()
	return ct>0
end
function c511010062.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsPreviousLocation(LOCATION_MZONE) then return end
	local ct=e:GetLabel()
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetRange(LOCATION_EXTRA+LOCATION_REMOVED+LOCATION_GRAVE)
	e1:SetCode(EVENT_PHASE+PHASE_STANDBY)
	if Duel.IsPhase(PHASE_STANDBY) and Duel.IsTurnPlayer(tp) then
		e1:SetLabel(-1)
		e1:SetReset(RESET_EVENT|RESETS_STANDARD|RESET_PHASE|PHASE_STANDBY|RESET_SELF_TURN,ct+1)
	else
		e1:SetLabel(0)
		e1:SetReset(RESET_EVENT|RESETS_STANDARD|RESET_PHASE|PHASE_STANDBY|RESET_SELF_TURN,ct)
	end
	e1:SetValue(ct)
	e1:SetCountLimit(1)
	e1:SetCondition(function(e,tp) return Duel.IsTurnPlayer(tp) end)
	e1:SetOperation(c511010062.spop2)
	Duel.RegisterEffect(e1,tp)
end
function c511010062.spop2(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsPreviousLocation(LOCATION_MZONE) then e:Reset() return end
	local val=e:GetValue()
	local ct=e:GetLabel()
	ct=ct+1
	e:SetLabel(ct)
	c:SetTurnCounter(ct)
	if ct==val and Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)>0 then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetCode(EVENT_ATTACK_ANNOUNCE)
		e1:SetReset(RESET_EVENT|RESETS_STANDARD|RESET_PHASE|PHASE_END)
		e1:SetLabel(e:GetLabel())
		e1:SetOperation(c511010062.atkop2)
		c:RegisterEffect(e1)
	end
end
function c511010062.atkop2(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local ct=e:GetLabel()
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetCode(EFFECT_SET_ATTACK_FINAL)
	e1:SetValue(c:GetAttack()*ct)
	e1:SetReset(RESET_EVENT|RESETS_STANDARD|RESET_PHASE|PHASE_DAMAGE)
	c:RegisterEffect(e1)
end
function c511010062.rktg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsFaceup,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
end
function c511010062.rkop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local g=Duel.GetMatchingGroup(Card.IsFaceup,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
	if #g==0 then return end
	for tc in g:Iter() do
		--Increase Ranks by 1
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_RANK)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetValue(1)
		e1:SetReset(RESET_EVENT|RESETS_STANDARD)
		tc:RegisterEffect(e1)
	end
end