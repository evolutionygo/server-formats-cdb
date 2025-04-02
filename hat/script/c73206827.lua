--光の結界
--Light Barrier
function c73206827.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--Toss a coin during the Standby Phase
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringc73206827(c73206827,0))
	e2:SetCategory(CATEGORY_COIN)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e2:SetCode(EVENT_PHASE+PHASE_STANDBY)
	e2:SetRange(LOCATION_FZONE)
	e2:SetCountLimit(1)
	e2:SetCondition(function(_,tp) return Duel.IsTurnPlayer(tp) end)
	e2:SetTarget(c73206827.cointg)
	e2:SetOperation(c73206827.coinop)
	c:RegisterEffect(e2)
	--Apply the "Light Barrier" effect to the player
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e3:SetCode(CARD_LIGHT_BARRIER)
	e3:SetRange(LOCATION_FZONE)
	e3:SetTargetRange(1,0)
	e3:SetCondition(c73206827.effectcon)
	c:RegisterEffect(e3)
	--Gain LP equal to the ATK of the destroyed monster
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringc73206827(c73206827,1))
	e4:SetCategory(CATEGORY_RECOVER)
	e4:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e4:SetRange(LOCATION_FZONE)
	e4:SetCode(EVENT_BATTLE_DESTROYING)
	e4:SetCondition(c73206827.reccon)
	e4:SetTarget(c73206827.rectg)
	e4:SetOperation(c73206827.recop)
	c:RegisterEffect(e4)
end
c73206827.listed_series={SET_ARCANA_FORCE}
c73206827.toss_coin=true
function c73206827.cointg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_COIN,nil,0,tp,1)
end
function c73206827.coinop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	if Duel.TossCoin(tp,1)==COIN_TAILS then
		c:RegisterFlagEffect(c73206827+1,RESET_EVENT|RESETS_STANDARD|RESET_PHASE|PHASE_STANDBY|RESET_SELF_TURN,0,2)
	end
end
function c73206827.effectcon(e)
	local c=e:GetHandler()
	return c:GetFlagEffect(c73206827+1)==0 or c:IsHasEffect(EFFECT_CANNOT_DISABLE)
end
function c73206827.reccon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local rc=eg:GetFirst()
	return rc:IsRelateToBattle() and rc:IsSetCard(SET_ARCANA_FORCE) and rc:IsFaceup() and rc:IsControler(tp)
		and (c:GetFlagEffect(c73206827+1)==0 or c:IsHasEffect(EFFECT_CANNOT_DISABLE))
end
function c73206827.rectg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local tc=eg:GetFirst():GetBattleTarget()
	local atk=tc:GetBaseAttack()
	if atk<0 then atk=0 end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(atk)
	Duel.SetOperationInfo(0,CATEGORY_RECOVER,nil,0,tp,atk)
end
function c73206827.recop(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Recover(p,d,REASON_EFFECT)
end